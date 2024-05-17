- [SSH](#ssh)
  - [IBM i requirements](#ibm-i-requirements)
    - [Bash Shell](#bash-shell)
    - [Home directory](#home-directory)
    - [User profile set up](#user-profile-set-up)
  - [SSH key authentication](#ssh-key-authentication)


# SSH


## IBM i requirements

Sicne we use the SSH protocoll to communicate with IBM i we need:
* SSH Deamon is up and running

    ```STRTCPSVR *SSHD```

* The open source package manager (YUM) is installed on IBM i

    You can do this using ACS


### Bash Shell

Recommended: BASH is installed and set to your profile
    
    In shell:
    ```sh
    yum install bash
    ```
    Set BASH as default shell to your profile via SQL (instead of ```*CURRENT``` you can also provide the profile name):
    ```sql
    CALL QSYS2.SET_PASE_SHELL_INFO('*CURRENT', '/QOpenSys/pkgs/bin/bash');
    ```


### Home directory

Home- & ```.ssh``` directory for your user profile should exist.

You also need the correct permission set for both directories because of security reasons

```sh
mkdir -p /home/$USER/.ssh
chmod 755 /home/$USER
chmod 700 /home/$USER/.ssh
```

### User profile set up

Define ```~/.profile```, ```~/.bashrc``` and ```~/.bash_profile``` file:

```sh
echo 'export PATH="/QOpenSys/pkgs/bin:$PATH"' >> ~/.profile
echo 'export TERM=xterm' >> ~/.profile
echo 'export PATH="/QOpenSys/pkgs/bin:$PATH"' >> ~/.bashrc
echo 'export TERM=xterm' >> ~/.bashrc
echo 'export PATH="/QOpenSys/pkgs/bin:$PATH"' >> ~/.bash_profile
echo 'export TERM=xterm' >> ~/.bash_profile
```

This is neseccary to have the correct ```PATH``` in the IBM i shell.

## SSH key authentication
  
* Linux

    ```sh
    ssh-keygen -b 4096
    # Enter your key name full qualified (e.g. /home/prouza/.ssh/academy_rsa)
    # Then you will be asked for a password. If you set one, you will be asked for it on each Login. If not you will be logged in without any prompt.
    ```

    On Linux you can simple use ```ssh-copy-id``` to copy the public key to your remote system.
    ```sh
    ssh-copy-id -i ~/.ssh/academy_rsa.pub prouza@academy
    ```

* Windows

    Do the same as for Linux, but open a WSL session for that, because this needs to be done in your WSL environment
    

On your local machine create the ```~/.ssh/config``` file (and directory) if not exist and add the following:

```
Host academy
  HostName academy
  IdentitiesOnly=yes
  User prouza
  IdentityFile ~/.ssh/academy_rsa
```

Now you should be able to login without a prompt: 
```ssh
[andreas@Andreas-Linux ~]$ ssh academy 
-bash-5.1$ 
```

  * Most problems here are
    * Home directory does not exist
    * Home directory does not match with user profile name
    * Owner of home directory is someone else
    * Permission of the home directory is not strict enough