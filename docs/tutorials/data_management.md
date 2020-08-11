# Storage Locations

Each user has access to several storage types and locations. The following
table lists the storage locations, limits and the use for which each is best
suited. 

| Location                  | Quota                                         | Usage                                                      |
| ------------------------- | --------------------------------------------- | ---------------------------------------------------------- |
| `/home/SUNetID`           | 32 GB                                         | Config files, important scripts, private software/data     |
| `/labs/PI_SUNetID`        | 128 GB (Free Tier)<br>7 TB and up (Full Tier) | Working data, lab shared software, results, etc.           |
| `/oak                 `   | [Oak Storage](https://oak.stanford.edu)       | Working data, lab shared software, results, etc.           |
| `/tmp`                    | no quota, limited by node capacity            | Per-job temporary files, data read many times during a job |

# Moving Data to/from SCG

## Globus

When moving large amounts of data, either in size, large counts of small files or both,
[Globus](https://www.globus.org) offers an easy to use web interface, a
personal connect client that can be installed on your laptop/desktop or on any
system you have access to and provides easy access and security using your
Stanford login. The [Globus](https://www.globus.org) tools can be used to move,
copy or sync data and will retry in the background on errors.

The SCG Globus endpoint is `SCG Cluster Storage`

---

## SCG OnDemand File App

The [SCG OnDemand File App
(https://ondemand.scg.stanford.edu/)](https://ondemand.scg.stanford.edu/pun/sys/files/)
offers an intuitive interface to navigate SCG storage and upload or download
files. It also includes built in tools to view and edit files in the web
browser. 

---

## Samba 
The Samba server at samba.scg.stanford.edu presents SCG storage to Stanford campus networks and VPN and makes it possible to easily mount the storage as a shared drive on your local system. Basic instructions/troubleshooting for each major Operating System are below or you can try this direct link if you are feeling lucky and aren't using Windows:

* [SCG Samba Direct Link](smb://samba.scg.stanford.edu)

### Linux

Open a terminal and run ```kinit SUNeTID@stanford.edu``` replacing SUNetID with your SUNetID. For example, 

~~~
griznog@gambusia:~$ kinit griznog@stanford.edu
Password for griznog@stanford.edu: 
griznog@gambusia:~$ klist
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: griznog@stanford.edu

Valid starting       Expires              Service principal
07/15/2019 13:08:37  07/16/2019 14:08:27  krbtgt/stanford.edu@stanford.edu
  renew until 07/22/2019 13:08:27
  griznog@gambusia:~$ 
~~~

In Linux open Nautilus or your distribution's file manager app and in the path
area or under a menu selection like `Connect to server...` enter

~~~
smb://samba.scg.stanford.edu/
~~~

and you should be presented with a window displaying the available network
shares. The special share labeled with your `SUNetID` is your SCG `$HOME`
directory.

### Mac OS X

Open a terminal and run ```kinit SUNeTID@stanford.edu``` replacing SUNetID with your SUNetID.

Open Finder, select ```Connect to server``` and enter 

~~~
smb://samba.scg.stanford.edu/
~~~

and you should be presented with a Finder window displaying the available network
shares. The special share labeled with your `SUNetID` is your SCG `$HOME` 
directory.

### Windows

Open an explore window and in the path section enter 

~~~
\\samba.scg.stanford.edu
~~~

At the login prompt, user your SUNetID and password to connect and you should
be presented with a window displaying the available network shares. The special
share labeled with your `SUNetID` is your SCG `$HOME` directory.

If login fails, you may need to run these commands from an Administrator enabled account:

~~~
ksetup /addkdc stanford.edu krb5auth1.stanford.edu
ksetup /addhosttorealmmap .stanford.edu stanford.edu
~~~

---

## rsync

[rsync](https://rsync.samba.org/documentation.html) is a time-tested tool for
moving data both between remote systems and locally. With a large number of
options and features, it's impossible to completely cover all potential uses of
[rsync](https://rsync.samba.org/documentation.html), so a few typical example
use cases are shown below. Basic
[rsync](https://rsync.samba.org/documentation.html) usage is 

~~~
rsync [options] [user@host:]/path/to/source [user@host:]/path/to/target
~~~

Note that only one of source and target can be a remote host. An example of
copying files from my local system to SCG is

~~~
rsync -a -v --partial --progress /mydrive/mydata griznog@login.scg.stanford.edu:/labs/ruthm/
~~~

In that command note the following:

* `--partial` : If the transfer fails, try to reuse any partially copied files when restarting. 
* `-a` : A shortcut for _archive_, pulling in recursion and several other options which attempt to make a complete copy of the source files/directories.
* `--progress` : Show a progress bar with transfer speed for each file transferred.
* `/mydrive/mydata` : A source directory. Note that including a trailing /, e.g., `/home/giznog/mydata/` will cause [rsync](https://rsync.samba.org/documentation.html) to work on the *contents* of the directory rather than the directory itself. This is a subtle difference that can lead to confusion on the target copy. 
* `griznog@login.scg.stanford.edu:/labs/ruthm/griznog/` : A target location. The trailing slash on a target has no significance. 

Some other interesting and useful [rsync](https://rsync.samba.org/documentation.html) options are:

* `--delete` : Useful when running [rsync](https://rsync.samba.org/documentation.html) to update a remote copy where you want to delete any files that have been deleted on the local copy.
* `--remove-source-files` : In cases where [rsync](https://rsync.samba.org/documentation.html) is being used to quickly clean up data, for instance to reduce usage due to quota, this option will remove files once they have been successfully copied rather than having to wait until the entire [rsync](https://rsync.samba.org/documentation.html) completes and deleting them manually. It does not remove directories.
* `--dry-run` : Show what [rsync](https://rsync.samba.org/documentation.html) would do, but don't actually do any copy or removal. Useful to test with `--delete` or `--remove-source-files` before running a potentially destructive [rsync](https://rsync.samba.org/documentation.html) command. 

---

## sftp

`sftp` provides a secure/encrypted analogs to `ftp` for any remote sites where ssh access is available. Example usage:

~~~
griznog@lepomis:~$ sftp griznog@login.scg.stanford.edu
Connected to login.scg.stanford.edu.
sftp> ls
Desktop    Documents  Downloads  Logs       Music      Pictures   Projects   
Public     Scratch    Templates  Videos     Working    bin        myfile     
ondemand   rpmbuild   
sftp> help
Available commands:
bye                                Quit sftp
cd path                            Change remote directory to 'path'
chgrp grp path                     Change group of file 'path' to 'grp'
chmod mode path                    Change permissions of file 'path' to 'mode'
chown own path                     Change owner of file 'path' to 'own'
df [-hi] [path]                    Display statistics for current directory or
                                   filesystem containing 'path'
exit                               Quit sftp
get [-afPpRr] remote [local]       Download file
reget [-fPpRr] remote [local]      Resume download file
reput [-fPpRr] [local] remote      Resume upload file
help                               Display this help text
lcd path                           Change local directory to 'path'
lls [ls-options [path]]            Display local directory listing
lmkdir path                        Create local directory
ln [-s] oldpath newpath            Link remote file (-s for symlink)
lpwd                               Print local working directory
ls [-1afhlnrSt] [path]             Display remote directory listing
lumask umask                       Set local umask to 'umask'
mkdir path                         Create remote directory
progress                           Toggle display of progress meter
put [-afPpRr] local [remote]       Upload file
pwd                                Display remote working directory
quit                               Quit sftp
rename oldpath newpath             Rename remote file
rm path                            Delete remote file
rmdir path                         Remove remote directory
symlink oldpath newpath            Symlink remote file
version                            Show SFTP version
!command                           Execute 'command' in local shell
!                                  Escape to local shell
?                                  Synonym for help
sftp> 
~~~

---

## scp

`scp` provides a secure/encrypted analog to `cp` which works with remote sources or targets. Example usage:

~~~
griznog@lepomis:~$ scp myfile griznog@login.scg.stanford.edu:
myfile                                               100%    0     0.0KB/s   00:00    
~~~

Useful options are `-r` for recursion (to copy directories) and `-v` for verbose output.

---

## rclone

[rclone](https://rclone.org/) is a powerful file transfer and synchronizing tool that works with a large number of cloud services. Configuration and usage is well documented on the [rclone website](https://rclone.org/). One of the most common uses of rclone on SCG is to keep copies of data on SCG archived or backed up to Box or Google Drive.

