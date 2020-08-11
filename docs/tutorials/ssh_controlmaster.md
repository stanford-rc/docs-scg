# Why use `ControlMaster`?

Two-factor auth is painful. Secure? Yes. Necessary? Yes. But, painful. Using the ssh config option `ControlMaster` can ease the pain a bit if you like to work with multiple SSH sessions to the login nodes. 

# What is `ControlMaster`?

ControlMaster is an ssh client option that will create a socket file which allows the initial ssh connection to a host be reused and optionally persist after the initial session has disconnected. In practice this means the first connection to a host will be authenticated normally, with password, GSSAPI, two-factor, etc., as required, but subsequent connections will simply reuse the initial connection without requiring authentication. 

# `~/.ssh/config` 

Add the following to end of `~/.ssh/config`, if that file doesn't exist then create it with permissions 0600, e.g., `touch ~/.ssh/config; chmod 0600 ~/.ssh/config`.

~~~
Host *
    # Have ControlMaster do the Right Thing(tm)
    ControlMaster auto
    # Put the socket file here. Optionally create a directory
    # for these and adjust this accordingly.
    ControlPath ~/.ssh/%r@%h:%p
    # If the initial and all other sessions exit, keep the
    # hold controlmaster open for 300 seconds before closing.
    ControlPersist 300s
~~~

# Test

Once that is in place, ssh to a host, open a second terminal and ssh to the same host and it should connect without prompting for authentication.

