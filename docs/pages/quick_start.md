- [Quick Start](#quick-start)
  - [Prerequesits](#prerequesits)
  - [Change build settings](#change-build-settings)
    - [Adapt build settings](#adapt-build-settings)
    - [Adapt global settings](#adapt-global-settings)
  - [Initiate your dummy build files](#initiate-your-dummy-build-files)
  - [VSCode as IDE](#vscode-as-ide)
  - [RDi as IDE](#rdi-as-ide)


# Quick Start

## Prerequesits

Because we need some tools on our PC (rsync and gnu-make) ...

* [Set up for build process](build_process.md#gnu-make.md) to create compile commands
  * Install gnu-make on that machine which should handle this
    * Could be on IBM i
    * Could be on your PC
      * for [Windows](integration_in_your_ide.md#on-windows) you need one of these:
        * Windows Subsystem for Linus (WSL)<br/>
          This is recommended for flexiblity and compatibility 
        * Cygwin
        * SSH mount
          You can mount your IBM i directly to your PC via SSHFS:
          https://github.com/winfsp/sshfs-win
      * for [Linux](integration_in_your_ide.md#on-linux) install
        * ```rsync```
        * ```make```
        * ```jq```
* Your prefered IDE (RDi or VSCode)
* [SSH](SSH.md#ssh) with key based authentication
* Get all your sources to the IFS in the folloging structure:
  * {lib}/{SRC-PF}/{member}.{attribute}.{type} ... like:
    * prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm
    * prouzalib/qsqlsrc/logger.sqltable.file
    * prouzalib/qcllesrc/testfile.pf.file
* Download this project


## Git configuration

* [hooks](git.md#hooks)
  * This will set the correct source "last modified timestamp"
* [config](git.md#git-config)
  * To handle special caracters in file names


## Change build settings

### [Adapt build settings](build_process.md#set-up-your-build-settings-makefiles)
Modify makefiles to your own settings
   * ```etc/global.mk```
     * IFS Path
     * Target lib (PGM, DB, ...)
     * ACTGRP
     * LIBLIST
   * ```etc/object_list.mk```
     * Objects to be build
     * Dependencies between objects
   * ```etc/.makeprofile.mk```
     * If you want to override some settings for your own environment
       * E.g. target lib (your developer library)
     * This file should be in the ```.gitignore``` file, so it's not synchronized with your project team members

### [Adapt global settings](build_process.md#global-settings)

The ```etc/global.cfg``` contains all settings for our scripts:
* Target system (IBM i)
* Directory in the IFS
* Git branch names
* etc.

## [Initiate your dummy build files](build_process.md#prepare-for-first-build)

Use full path in the command!

```sh
gmake init # to create all necessary directories for build
gmake all --touch --directory=/home/prouza/myproject/build --makefile=/home/prouza/myproject/make/makefile
```

## VSCode as IDE

1. Install [VSCode extensions](integration_in_your_ide.md#vscode-extensions)
2. Open the project directory in vscode
3. For Windows:<br/>
   Add the config line from ```.vscode/windows.settings.json``` to the ```.vscode/settings.json``` file.<br/>
   This tells vscode in which type of terminal our script needs to run.<br/>
   See [Project settings](integration_in_your_ide.md#project-settings)
4. [Just run the build](integration_in_your_ide.md#lets-run-the-build)

## RDi as IDE

1. Import the Git Repo as new project
2. Add build commands in ```External Tools Configurations```
3. Run the build