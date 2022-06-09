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

## VSCode or RDi & GNU Make

Also in both IDEs you can define own build commands where I put the ```gmake all``` command in it.

