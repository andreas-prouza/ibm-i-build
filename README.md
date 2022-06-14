# Overview

My DevOps concept includes multiple components like GIT as a basis for source management.

In this example I focus on the build part of the DevOps concept.

For all IBM i builds I use 2 components:

* GNU Make
  
  Build you source

  * In correct order
  * Consider dependencies (PF/LF/DSPF --> RPG)
  
* VSCode or RDi with RSYNC
  
  To synchronise your sources to the build server (IBM i)

# GNU Make

## Installation

You can install ist via ACS OpenSource-Package-Mangager or via YUM in the console
```sh
yum install git

===================================================================
 Package        Arch          Version       Repository        Size
===================================================================
Installing:
 make-gnu       ppc64         4.2-2         ibmi-base        520 k
```

## Set up our Makefile(s)

```make``` uses ```makefile```s in which the plan is set up how to build your application.

For more details about makefiles you can find a lot of stuff in the internet.

I split it up into 5 makefiles

1. makefile

    The basic config file to start the build

2. env.mk

    This I use to define search paths and environment variables

3. .makeprofile.mk

    This file shouldn't be synchronised to the GIT project since this is individually for each user.<br/>
    If you are using GIT (and you should), this files is in the ```.gitignore``` list.<br/>
    Here you can overwrite for example the source directory to you own working directory in the IFS.

    If you are not using GIT and you only have one directory where all developers are working with, you can just delete the ```.makeprofile.mk``` file.

4. objecte_list.mk

    A list of all objects and their dependencies<br/>
    First all objects are stored in a variable with a blank as separator

    Then all objects with dependencies are listed including all dependiencies which ```make``` should consider

5. make_compile_rules.mk

    For all type of objects the build command is defined (RPG, CL, DSPF, SQL Tables, ...)<br/>

## Run GNU Make

### Build directories
This Makefiles uses 2 directories in the IFS for the build output

* build
  
    For each compiled/created object a dummy file will be created in the ```build```.<br/>
    The creation timestamp of these files will be used to compare it with the last changed timestamp of the source of the object.<br/>
    If the source is yunger then the compile process of the object will be started.<br/>
    Otherwise it will be ignored.

* logs

    Contains compile output: spooled files and job log

### Preperation

If you don't want to build all from scretch but only build changed sources, you can use the following:
```sh
gmake init # to create all necessary directories for build
gmake all --touch --directory=build --makefile=/home/prouza/myapp/makefile
```
This only creates the dummy build object files in the ```build``` directory.

### Run build

After all this is done you can use ```gmake``` to build you applications.
```sh
gmake all
```


## Summary

1. Install GNU Make
2. Create a project directory in you working IFS path (e.g. /home/prouza/myapp)
3. Copy all sources into this directory.<br/>
All source files are subdirectories (e.g. /home/prouza/myapp/qrpglesrc/test.rpgle)
4. Copy all make-config-files
5. Modify the makefiles
   * makefile
   * object_list.mk
   * .makeprofile.mk
6. Open a terminal (QSH, Putty, ...)
7. Make sure you have the ```$PATH``` variable set correct (```/QOpenSys/pkgs/bin``` needs to be in the list)<br/>
I also use ```BASH``` as shell. It makes life much easier.
8. Go into your directory

    ```sh
    cd /home/prouza/myapp
    ```
9.  Run the build

    ```sh
    gmake all
    ```


# Integration in your IDE

## VSCode
You should have installed the ```Code for IBM i``` extension.

With this you can work with your sources directly in the IFS of your IBM i.

If you use GIT I recommend to install the ```Git Graph``` extension.

## VSCode or RDi & RSYNC

After our project was set up successfully we can now focus on our favourite IDE.

In both IDEs you can use external commands like ```rsync``` to automatically synchronise your code with your working directory in the IFS.<br/>
You can set up both IDEs to do this automatically after saving.

Therefore I am using 2 extensions:

* Run on Save
  
    Automatically sync when source is saved.<br/>
    So no need to do some extra sync.
* Command Runner
  
    To trigger the sync manually (e.g. if I switch branch) using:<br/> 
    STRG+P --> Select: Run Command --> Select: Sync project

```.vscode/settings.json```

```json
{
    "emeraldwalk.runonsave": {
        "commands": [
            {
                "match": ".*/myapp.*/.*$",
                "isAsync": true,
                "cmd": "rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','build','logs','.vscode','.project','.gitignore'} /home/andreas/projects/myapp/ ibmi:/home/prouza/myapp/"
            }
        ]
    },
    "command-runner.terminal.name": "Sync project",
    "command-runner.terminal.autoClear": true,
    "command-runner.terminal.autoFocus": true,
    "command-runner.commands": {
        "Sync source to IBM i": "rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','build','logs','.vscode','.project','.gitignore'} /home/andreas/projects/myapp/ ibmi:/home/prouza/myapp/",
        "Sync logs back": "rsync -avz --rsync-path=/QOpenSys/pkgs/bin/rsync --include={'logs/***','build/***'} --exclude='*' ibmi:/home/prouza/myapp/ /home/andreas/projekte/projects/myapp/",
    }
}
```

In addition I also use the "Work with Actions" possibility in the ```Code for IBM i``` extension to build the application with gmake.<br/>
In "Command to run" field I use:

```sh
/QOpenSys/pkgs/bin/bash -c "error=*EVENTF lib1=&CURLIB cd ~/myapp; gmake all"
```
The advantage of this is, that I get the compile information directly in my currently opened source.<br/>
So if I am trouble shooting with a source change, this is my choise.<br/>
As far as I know it even works if my opened source is a local one and not opened from IBM i IFS.

I also use the "Work with Actions" to show a list of changed sources which would be compiled

## VSCode or RDi & GNU Make

Also in both IDEs you can define own build commands where I put the ```gmake all``` command in it.

