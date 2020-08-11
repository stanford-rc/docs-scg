## Cluster Overview
The SCG cluster is a standard, HPC-style shared-resource cluster environment consisting of

* Hardware
    * Compute and Login nodes
    * Storage systems
    * Ethernet network
* Software
    * Operating System (Linux: [CentOS 7.x](https://www.centos.org/))
    * Job Scheduler ([Slurm](https://slurm.schedmd.com/overview.html))
    * Software Applications

## CLI/Terminal Access
Primary access to the SCG resources is via a [Command Line
Interface](http://www.linfo.org/command_line_interface.html), in this case
interfacing to the [Linux
CLI](https://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything)
accessed remotely via [Secure Shell
(ssh)]([https://en.wikipedia.org/wiki/Secure_Shell). To access via SSH there
will need to be an SSH client installed on the client workstation, desktop or
laptop or a web based terminal is available via [SCG OnDemand Shell
Access](https://ondemand.scg.stanford.edu/pun/sys/shell/ssh/default).  For
locally installed clients, depending on the Operating System used on the client
system there are several options:

* Windows
    * [MobaXterm](https://mobaxterm.mobatek.net/) (free and highly recommended)]
    * [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) (free)
    * [bitvise](https://www.bitvise.com/ssh-client-download) (free client)
    * [and many others...](https://www.htpcbeginner.com/best-ssh-clients-windows-putty-alternatives/)
* Mac OSX (note that ssh tools are built in, but there are several terminal options)
    * [Built-in Terminal app](http://blog.teamtreehouse.com/introduction-to-the-mac-os-x-command-line)
    * [iTerm2](https://www.iterm2.com/) (free and highly recommended) 
* Linux
    * Everything needed is included. Because ... Linux.

Working at the command line is not covered here, but there are many, many
resources online to help get started using the Bash shell and unix command line
tools. A short list of example sites is:

* [Linux Tutorial](https://ryanstutorials.net/linuxtutorial/)
* [linuxcommand.org](http://www.linuxcommand.org/)
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/)
* [Beginner's Guide to the Bash Terminal](https://www.youtube.com/watch?v=oxuRxtrO2Ag)


## Example SSH connection
Using the SSH client, connect to the cluster by ssh'ing to the login nodes.
`login.scg.stanford.edu` is an alias which will resolve to the "best" login
node available from a pool of login nodes:

~~~no-highlight
[griznog@gambusia ~]$ ssh griznog@login.scg.stanford.edu
griznog@login.scg.stanford.edu's password: 
Duo two-factor login for griznog 

Enter a passcode or select one of the following options:

 1. Duo Push to XXX-XXX-4102
 2. Phone call to XXX-XXX-4102 
 3. SMS passcodes to XXX-XXX-4102

Passcode or option (1-3): 1
Success. Logging you in...
Last login: Fri Jan  4 17:35:46 2019 from 171.66.185.235
               __      __   _                    _        
               \ \    / /__| |__ ___ _ __  ___  | |_ ___  
                \ \/\/ / -_) / _/ _ \ '  \/ -_) |  _/ _ \ 
                 \_/\_/\___|_\__\___/_|_|_\___|  \__\___/ 
                                                          
                    ___ __ __ _    O       o O       o O       o
                   (_-</ _/ _` |   | O   o | | O   o | | O   o |
                   /__/\__\__, |   | | O | | | | O | | | | O | |
                          |___/    | o   O | | o   O | | o   O |
                                   o       O o       O o       O
              

  Keep up-to-date on SCG by following #announce in our Slack Workspace at

                       https://susciclu.slack.com

  Problems:
     Send email to scg-action@lists.stanford.edu or if you prefer a more
     interactive method, use your Stanford email to sign up at our Slack work-
     space: https://susciclu.slack.com and ask in #general or dm to @griznog

  Like Disclaimers?:
     This system may contain research data whose use is subject 
     to restrictions from government agencies, contractual partners, or 
     research sponsors.  Any use of this data must be authorized by the 
     Principal Investigator. Contact scg-action@lists.stanford.edu for more
     information on the terms and conditions governing the use of this data.

[griznog@smsx10srw-srcf-d15-38 ~]$ 
~~~


NOTE
: SCG accepts Kerberos tickets, SSH pubkey and Password authentication as the
first factor for two-factor auth. If your laptop or workstation is configured
with Stanford Kerberos, you may not see a password prompt or may be able to
avoid it by using <pre>kinit SUNetID@stanford.edu</pre> before starting ssh.
You can also set up SSH key authentication.





