- [GNU Make](#gnu-make)
  - [Installation](#installation)
    - [On IBM i](#on-ibm-i)
    - [On you PC](#on-you-pc)
  - [Set up your Makefile(s)](#set-up-your-makefiles)
  - [Run GNU Make](#run-gnu-make)
    - [Build directories](#build-directories)
    - [Preperation](#preperation)
    - [Run build](#run-build)
  - [Summary](#summary)


# GNU Make

## Installation 

### On IBM i

You can install ist via ACS OpenSource-Package-Mangager or via YUM in the console
```sh
yum install make-gnu

===================================================================
 Package        Arch          Version       Repository        Size
===================================================================
Installing:
 make-gnu       ppc64         4.2-2         ibmi-base        520 k
```

### On you PC

* Linux
  
```sh
    sudo apt install make
    sudo pacman -S make
    sudo yum install make
```

* In Windows (WSL)
  
```sh
    sudo apt update
    sudo apt install make
```


You may already noticed that we have 2 different type of make commands ```make``` and ```gmake```.<br/>
This depends on the installation of gnu make (PC or IBM i, Windows WSL or Linux). But it's always the same.

## Set up your Makefile(s)

```gmake``` uses ```makefile``` in which the plan is set up how to build your application.

For more details about makefiles you can find a lot of stuff in the internet.

I split it up into 5 makefiles

1. ```makefile```

    The main config file to start the build<br\> 
    (source location in IFS, target lib, activation group, ...)

2. ```env.mk```

    This I use to define search paths and environment variables.

3. ```.makeprofile.mk```

    This file shouldn't be synchronised to the GIT project since this is individually for each user.<br/>
    If you are using GIT (and you should), this files is added to the ```.gitignore``` list.<br/>
    Here you can overwrite for example the source directory to your own working directory in the IFS.<br/>
    Or you can override the target library for compiling to your own library

    If you are not using GIT and you only have one directory where all developers are working with, you can just delete the ```.makeprofile.mk``` file.

4. ```objecte_list.mk```

    A list of all objects and their dependencies.<br/>
    First all objects are stored in a variable with a blank as separator.

    Then all objects with dependencies are listed including all dependiencies which ```make``` should consider.<br/>
    You can find a detailed description in this file.<br/>
    If you have special definitions for an object, you can also define it there (e.g. activation group, binding directory, target library, ...)

    In the following example the program ```mypgm``` depends on these objects:
    ```
    prouzalib/mypgm.sqlrpgle.pgm: \
      prouzalib/logger.sqlrpgle.srvpgm \
      prouzalib/errhdlsql.sqlrpgle.srvpgm \
      prouzalib/date.rpgle.srvpgm \
      prouzalib/myfile.pf.file \
      prouzalib/myview.sqlview.file
    ```
    So, if one of the service programs (```logger```, ```errhdlsql```, ```date```), the table ```myfile``` or the view ```myview``` change also ```mypgm``` will be created.

5. ```compile_rules.mk```

    For all type of objects you want to create the build command needs to be defined here (RPG, CL, DSPF, SQL Tables, ...)<br/>
    I already set up the compile rules, so it should be able to handle most of your (ILE) builds.<br/>
    If you also want to build objects like menues or printer files (or whatever you want), you can simple add the command at the end of this file.

## Run GNU Make

From here, we haven't set up our IDE, but we are able to login to our IBM i via SSH and run the build directly on the server.<br/>
So, login via SSH to your IBM i and go to your project directory.

### Build directories
The build uses 2 directories in the IFS for the build output

* ```./build```
  
    For each compiled/created object a dummy file will be created in the ```./build``` directory.<br/>
    The creation timestamp of these files will be used to compare the "compiled object" with the last changed timestamp of the source.<br/>
    If the source is yunger then the compiled object (the dummy file) the compile will be started for this object.<br/>
    Otherwise it will be ignored.

* ```./logs```

    Contains compile output: spooled files and job log of each object


### Preperation
Since the ```gmake all``` checks if a source has been changed since last build, gmake would compile all sources on very first run.

If you don't want to build all from scretch and only wants to build new changed sources from now, you can use the following:
```sh
gmake init # to create all necessary directories for build
gmake all --touch --directory=/home/prouza/myproject/build --makefile=/home/prouza/myproject/makefile
```
This only creates the dummy build object files in the ```./build``` directory.

### Run build

After all this is done you can use ```gmake``` to build all changes in your application.
```sh
gmake all
```


## Summary

1. Install GNU Make on IBM i
2. Create a project directory in you working IFS path (e.g. /home/prouza/myproject)
3. Copy all sources into this directory.<br/>
All source files are subdirectories (e.g. /home/prouza/myproject/qrpglesrc/logtest.rpgle)
4. Copy all make-config-files
5. Modify the makefiles to your own settings
   * makefile
     * IFS Path
     * Target lib (PGM & DB)
     * ACTGRP
     * LIBLIST
   * object_list.mk
     * If you want to add additional objects to be build
   * .makeprofile.mk
     * If you want to override some settings for your own environment
6. Open a terminal (QSH, Putty, ...)
7. Make sure you have the ```$PATH``` variable set correct (```/QOpenSys/pkgs/bin``` needs to be in the list)<br/>
I also use ```BASH``` as shell. It makes life much easier.
8. Go into your directory

    ```sh
    cd /home/prouza/myproject
    ```
9.  Run the build

    ```sh
    gmake all
    ```
