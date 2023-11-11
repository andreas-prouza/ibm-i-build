- [GNU Make](#gnu-make)
  - [Installation](#installation)
  - [General](#general)
    - [On IBM i](#on-ibm-i)
  - [Set up your build settings (makefiles)](#set-up-your-build-settings-makefiles)
- [Build scripts](#build-scripts)
  - [Global settings](#global-settings)
  - [Prepare for first build](#prepare-for-first-build)
    - [Directories](#directories)
    - [Create your dummy files first](#create-your-dummy-files-first)
    - [Run build](#run-build)


# GNU Make

## Installation 

Set up is shown in [here](/docs/pages/integration_in_your_ide.md#prerequisites).

## General


You may have noticed that we have 2 different types of make commands, ```make``` and ```gmake```.<br/>
This depends on your gnu-make installation (PC or IBM i, Windows WSL or Linux). But it's always the same.

### On IBM i

Let's see what's behind the ```gmake``` command on an IBM i:

```sh
-bash-5.2$ which gmake
/QOpenSys/pkgs/bin/gmake

-bash-5.2$ ls -la /QOpenSys/pkgs/bin/gmake
lrwxrwxrwx 1 qsys 0 8 Dez 30  2022 /QOpenSys/pkgs/bin/gmake -> make
```
As you can see, ```gmake``` is just a symbolic link to ```make```.

## Set up your build settings (makefiles)

```make``` uses a ```makefile``` which sets out the plan for building your application.

You can find lots of stuff on the internet for more details on makefiles.

Here I've split it into the following makefiles

1. ```make/makefile```

    The main config file to start the build<br\> 
    (help, cleanup, initialisation, run)

2. ```make/env.mk```

    To define search paths and environment variables.

2. ```etc/global.mk```

    It contains build settings.<br/>
    (Source path, ACTGRP, LIBL, target release, ...)

3. ```etc/.makeprofile.mk```

    This file shouldn't be synchronised with the GIT project, as this is user-specific.<br/>
    If you use GIT (and you should), this file will be added to the ```.gitignore``` list.<br/>
    For example, you can overwrite the source directory with your own working directory in the IFS.<br/>
    Or you can override the target library to compile into your own library

4. ```etc/objecte_list.mk```
   
   Listing all objects and how they depend on one another.<br/>
    
   * Object list
  
     * Hard-coded
    
       This can be a hard-coded list of objects.<br/>
       You need to take care of new sources to add them to the list (manually or automatically).

     * Dynamic list

       The list is generated dynamically by the sources themselves.<br/>
       This may take some time if you have many sources and a slow machine.

   * Dependency list

       Objects with dependencies to other objects are listed. ```make``` will consider them during the build process.<br/>
       You can find a detailed description in this file.<br/>
        
       If you need to define special definitions for an object, you can also do so here (e.g. activation group, binding directory, target library, ...)

      In the following example, the program ```mypgm``` depends on these objects:
      ```
      prouzalib/qrpglesrc/mypgm.sqlrpgle.pgm.obj: \
            prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
            prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj \
            prouzalib/qrpglesrc/date.rpgle.srvpgm.obj \
            prouzalib/qddssrc/myfile.pf.file.obj \
            prouzalib/qsqlsrc/myview.sqlview.file.obj
      ```
    So, if one of the service programs (```logger```, ```errhdlsql```, ```date```) or the table ```myfile``` or the view ```myview``` changes, ```mypgm``` will also be created.

5. ```compile_rules.mk```

    For each type of object you want to build, the build command must be defined here (RPG, CL, DSPF, SQL tables, ...).<br/>
    I have already set up the compilation rules, so it should be able to handle most of your (ILE) builds.<br/>
    If you also want to create objects such as menus or printer files (or whatever you want), you can simply add the command at the end of this file.

# Build scripts

Gnu-make is only one part of the build process. It also includes:
* Cleaning up
* Creating the build script (using gnu-make)
* Synchronising the sources and build script to the IBM i
* Get all the logs back to your PC
* etc.

I use a few scripts to get this job done.

## Global settings

The ```etc/global.cfg``` file contains all the settings needed by our scripts:

* Synchronize sources<br/>
  (lokal <--> remote)
* Start build<br/>
  Run make
* Creation of deployment script<br/>
  This will run on the IBM i
* Creation of deploy file<br/>
  If a deployment tool need it
* Start of deployment
* Some Git actions
* etc.


## Prepare for first build

### Directories
The build uses 2 directories in the IFS for the build output

* ```./build```
  
    For each created object a dummy file will be created in the ```./build``` directory.<br/>
    The creation timestamp of these files will be used to compare the "compiled object" with the last changed timestamp of the source.<br/>
    If the source is yunger then the compiled object (the dummy file) the compile will be started for this object.<br/>
    Otherwise it will be ignored.

* ```./logs```

    Contains compile output: spool file and job log of each object.


### Create your dummy files first

Since ```gmake all``` checks if a source has changed since the last build, gnu-make would compile all sources on the very first run.

If you don't want to build everything from scratch and just want to build new modified sources from now on, you can use the following commands:<br/>
(This should be possilbe if dyou have finished the [preperation topic](integration_in_your_ide.md#prerequisites).)

Make sure you use the full path name!

```sh
gmake init # to create all necessary directories for build
gmake all --touch --directory=/home/prouza/myproject/build --makefile=/home/prouza/myproject/make/makefile
```

This only creates the dummy build object files in the ```./build``` directory.

### Run build

Once all this is done, you can run the script to create compile script for all the changes in your application.

You can choose the way you like:

![run-command-2.jpg](/docs/assets/run-command-2.jpg)

or

![vscode-actions.jpg](/docs/assets/vscode-actions.png)

or

![rdi-actions.jpg](/docs/assets/rdi-actions.png)

The result:

![vscode-show-change-obj.jpg](/docs/assets/vscode-show-change-obj.png)

