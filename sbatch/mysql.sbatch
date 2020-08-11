#!/bin/bash

#SBATCH --partition=nih_s10
#SBATCH --time=4-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --job-name=vntrseek
#SBATCH --account=yesavage
#SBATCH --mail-type=TIME_LIMIT_80

# Needs a trap.

# Funciton to allow easy semantics for exiting on error
function die () {
  echo $1
  exit 1
}


# Find an open port in some random high range. 
function findport () {
  limit=128
  attempts=0
  errval=1
  port=$(( ${SLURM_JOB_ID} % 32768 + 16384 + ${RANDOM} % 256 ))
  while nc -z localhost $port; do
    let port=port+1
    let attempts=attempts+1
    if [[ ${attemtps} -gt ${limit} ]]; then
      return $errval
    fi
  done
  echo ${port}
  return 0
} 
    
echo "Running on node $(hostname -s)"
echo "I am using ${SLURM_CPUS_PER_TASK} cores."

#######################################################################################
#########                   MariaDB (MySQL) Server Setup                     ##########
#######################################################################################
# Database location.
DB_DIR=/tmp/mariadb_${SLURM_JOB_ID}
[[ -d ${DB_DIR} ]] || mkdir ${DB_DIR}

# User, pass, port, ...
DB_USER=${USER}
DB_PASSWORD=$(pwgen 8 1)
DB_PORT=$( findport )

# vntrseek uses this to name the database, config files, etc.
DB_NAME=db_${SLURM_JOB_ID}

# MariaDB (MySQL) config file.
cat > ${DB_DIR}/my.cnf << EOF 
[mysqld]
datadir=${DB_DIR}
bind-address=127.0.0.1
port=${DB_PORT}
socket=${DB_DIR}/mariadb.sock
user=${USER}
symbolic-links=0
# We skip this, vntrseek assume a TCP connection.
# skip-networking
innodb_buffer_pool_size=1G
innodb_additional_mem_pool_size=20M

[mysqld_safe]
log-error=${DB_DIR}/mariadbd.log
pid-file=${DB_DIR}/mariadbd.pid

[mysql]
port=${DB_PORT}
socket=${DB_DIR}/mariadb.sock
# These must be commented, or else mysql client breaks.
# Just putting them here for reference.
# user=${DB_USER}
# password=${DB_PASSWORD}
EOF

# Just for fun, lets keep this to ourselves. /tmp is private, but ... belt+suspenders.
chmod 0640 ${DB_DIR}/my.cnf

# Do this if the job expects .my.cnf to work for connecting to this
# specific database.
# ln -s ${DB_DIR}/my.cnf ~/.my.cnf

# Set up MariaDB
mysql_install_db --datadir=${DB_DIR} || die "Failed to install mysql database."

# Start MariaDB
mysqld_safe --defaults-file=${DB_DIR}/my.cnf --datadir=${DB_DIR} > ${DB_DIR}/mysqld_safe.out 2>&1 &
[[ $? ]] || die "Failed to start mysqld_safe"
 
# Pause for effect, and to let mysql finish starting.
sleep 4

# Set up database and user. I *think* vntrseek will do this for us if the database 
# isn't there, but doing it here is a good sanity check that MariaDB is running 
# properly.
mysql -u root --socket=${DB_DIR}/mariadb.sock << EOF
create user '${DB_USER}'@'localhost' identified by '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'localhost';
flush privileges;
create database ${DB_NAME};
quit
EOF
[[ $? ]] || die "Failed to create mysql user ${DB_USER}."


# Things that use MariaDB go here. 
# The DB_* variables can be used for making connections.

# Wait for mysqld_safe to exit.
wait

