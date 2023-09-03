- [Integration in your IDE](#integration-in-your-ide)
  - [VSCode](#vscode)
  - [VSCode \& RSYNC](#vscode--rsync)
    - [Prerequisites](#prerequisites)
      - [IBM i](#ibm-i)
      - [Linux](#linux)
      - [Windows](#windows)
    - [VSCode extensions](#vscode-extensions)
    - [Let's run the build](#lets-run-the-build)
    - [Sync automatically after code changing](#sync-automatically-after-code-changing)
    - [Using ```Code for IBM i```](#using-code-for-ibm-i)
  - [RDi \& RSYNC](#rdi--rsync)
  - [VSCode or RDi \& GNU Make](#vscode-or-rdi--gnu-make)

# Integration in your IDE


## Prerequisites
You need to install ```rsync``` on your local machine and on IBM i.

In addition install ```make``` on your local machine if you want to use it local.

### IBM i
```sh
yum install rsync
```

### Linux
On Linux this is very easy. It only depends which package manager you are using (maybe it's already installed):
```sh
sudo yum install rsync make
sudo apt-get install rsync make
sudo pacman -S rsync make
```

Rename the ```linux.settings.json``` to ```settings.json``` to get the Linux settings.

### Windows
```rsync``` is a Unix based utility. So you can't just easily install it on Windows.<br/>
You have 2 options:
* WSL (Windows Subsystem for Linux)
* Cygwin

#### Using WSL (Windows Subsystem for Linux):

1. Open the "Turn Windows features on or off"

2. Choose "Windows Subsystem for Linux" and select "OK"
   
    ![build-command](../assets/windows-features.png)

3. Enable Virtual Machine feature

     ```dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart```

4. Reboot your PC

5. Open the Microsoft Store and search for "Linux Ubuntu" and install it
   
    ![build-command](../assets/install-ubuntu.png)

6. After installing the Linux distribution "Launch" it.
   
   The first time you may will be asked to set up a user/password for this environment.


You can also do this via PowerShell. You will find a good documentation in the internet for this process if you want to do it in that way.

After this is done you can use ```rsync``` using WSL in the Windows CMD:
```sh
wsl rsync ...
```

#### Using Cygwin

If you prefere Cygwin download and install it with these options:
  * openssh
  * rsync
  * make

After setup open the Cygwin terminal. Add this in your ```.bash_profile```:

```sh
export SHELLOPTS
set -o igncr
```


## VSCode
You should have installed the ```Code for IBM i``` extension.

With this you can work with your sources directly in the IFS of your IBM i.

If you use GIT I recommend to install the ```Git Graph``` extension.

## VSCode & RSYNC

After our project was set up successfully we can now focus on our favourite IDE.

In both IDEs you can use external commands like ```rsync``` to automatically synchronise your code with your working directory in the IFS.<br/>
You can set up in both IDEs (RDi and VSCode) to do this automatically after saving your changes in the source.


### VSCode extensions

Therefore I am using the following extensions:

* IBM i Development Pack

    This contains all IBM i extensions, which we want to use for development

* Run on Save
  
    Automatically sync when source is saved.<br/>
    So no need to do some extra sync.

* Command Runner
  
    To trigger the sync manually (e.g. if I switch branch) using:<br/> 
    CTRL+SHIFT+P --> Select: Run Command --> Select: Run Build (summary output)

* GitLens and Git Graph (if you are using Git)
  
* WSL (for Windows only)

    Since we use the Windows Subsystem for Linux (WSL) to synchronize the source to our IBM i, we need this extension to make our Windows path linux like.


You can just use the ```.vscode/settings.json``` from this project.<br/>
Rename the ```windows.settings.json``` to ```settings.json``` to get the Windows settings.

Don't forget to change: 
* hostname
* user (but not necessary if you use the ```~/.ssh/config```)
* IFS target directory

Notice for Windows:<br/>
The standard terminal is set to ```Ubuntu (WSL)``` for this project in the ```.vscode/settings.json```.<br/>
If you prefere Cygwin, you need to change the terminal property there.<br/>
You may need to exit the current Windows terminal in vscode to get the config in action.


### Let's run the build
Use CTRL+SHIFT+P. When you start typing "run command" you should get correct list to select the "Run Command" extension.

![run-command](../assets/run-command.png)

Now you will get a list of commands, which are defined in the ```.vscode/settings.json```.

![build-command](../assets/build-cmd.png)

Now the command will be issued:
1. Sync sources to the IBM i
2. Run build
3. Sync back the logs

You may get asked for your password.<br/>
I use key authentication, so I will get signed in automatically.<br/>
(This is btw the most secure way to connect to servers. Some Linux admins only allow key authentication.)

```sh
[andreas@Andreas-Linux ibm-i-build]$ rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','logs','.vscode','.project','.gitignore'}  /home/andreas/projekte/common/ibm-i-build/ prouza@academy:/home/prouza/myproject/; ssh prouza@academy "source .profile; cd /home/prouza/myproject; gmake all | grep crtcmd\|summary | cut -d '|' --output-delimiter ': ' -f 2"; rsync -avz --rsync-path=/QOpenSys/pkgs/bin/rsync --include={'logs/***','build/***'} --exclude='*' prouza@academy:/home/prouza/myproject/  /home/andreas/projekte/common/ibm-i-build 
sending incremental file list

sent 737 bytes  received 17 bytes  502,67 bytes/sec
total size is 138.482  speedup is 183,66
summary ===============================================================
summary Build RPG: 2 testlog.rpglepgm testlog2.sqlrpglepgm
summary Build CL: 0 
summary Build DSPF: 0 
summary Build SRVPGM: 2 logger.sqlrpglemod testmod.rpglemod
summary Build DB: 1 logger.sqltableobj
summary ===============================================================
receiving incremental file list
build/
build/logger.sqltableobj
build/logger.sqlrpglemod
build/prouzadir.bnddir
build/prouzadir.bnddirinclude
build/prouzadir.bnddirtarget
build/testlog.rpglepgm
build/testlog2.sqlrpglepgm
build/testmod.rpglemod
logs/
logs/logger.sqltableobj.error.log
logs/logger.sqltableobj.log
logs/logger.sqlrpglemod.error.log
logs/logger.sqlrpglemod.log
logs/testlog.rpglepgm.error.log
logs/testlog.rpglepgm.log
logs/testlog2.sqlrpglepgm.error.log
logs/testlog2.sqlrpglepgm.log
logs/testmod.rpglemod.error.log
logs/testmod.rpglemod.log

sent 2.636 bytes  received 11.154 bytes  9.193,33 bytes/sec
total size is 258.516  speedup is 18,75
[andreas@Andreas-Linux ibm-i-build]$ 
```

You should have a logs directory containing the spools of the compiled object and the joblog for each object.

![logs](../assets/logs.png)

Notice:<br/>
In this project I am using ```make``` only on the PC.<br/>
```make``` generates all the compile commands (in the correct order) which will be written to a script.<br/>
The script will be transfered to the IBM i and executed.<br/>
This is much faster then doing it all on the IBM i.

### Sync automatically after code changing
Since we also have configured the ```Run On Save``` extension, everytime a source get saved, the project folder will be synced with the IBM i.

For example: I changed a line of code in the ```testlog2.sqlrpgle``` source.<br/>
In the ```Output``` view of vscode you can see the output:

```sh
Running on save commands...
*** cmd start: rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','build','logs','.vscode','.project','.gitignore'} /home/andreas/projekte/common/ibm-i-build/ prouza@academy:~/myproject/
Run on Save done.
sending incremental file list
qrpglesrc/testlog2.sqlrpgle

sent 1.201 bytes  received 46 bytes  831,33 bytes/sec
total size is 158.956  speedup is 127,47
```

### Using ```Code for IBM i```
In addition I also use the "Work with Actions" possibility in the ```Code for IBM i``` extension to build the application with gmake.<br/>
In "Command to run" field I use:

```sh
/QOpenSys/pkgs/bin/bash -c "error=*EVENTF lib1=&CURLIB cd ~/myproject; gmake all"
```
The advantage of this is, that I get the compile information directly in my currently opened source.<br/>
So if I am trouble shooting with a source change, this is my choise.<br/>
As far as I know it even works if my opened source is a local one and not opened from IBM i IFS.

I also use the "Work with Actions" to show a list of changed sources which would be compiled

## RDi & RSYNC
Like in vscode you can also define in RDi (Menu: Run --> External Tools --> External Tools Configurations --> create a new "Program" konfiguration).

Detailed information will follow.

## VSCode or RDi & GNU Make

Also in both IDEs you can define own build commands where I put the ```gmake all``` command in it.


