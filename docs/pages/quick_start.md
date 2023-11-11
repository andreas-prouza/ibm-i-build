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
* [Build process](build_process.md#gnu-make.md) to create compile commands
  * Install it on that machine which should handle this
  * Could be on IBM i
  * Could be on your PC
* Your prefered IDE (RDi or VSCode)
* [SSH](SSH.md#ssh) with key based authentication

Because we need some tools on our PC (rsync and gnu-make) ...

* for [Windows](integration_in_your_ide.md#windows) you need one of these:
  * Windows Subsystem for Linus (WSL)<br/>
    This is recommended for flexiblity and compatibility 
  * or Cygwin
* for [Linux](integration_in_your_ide.md#linux) install
  * ```rsync```
  * ```make```
  * ```jq```


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

```etc/global.cfg```
* Target system (IBM i)
* Directory in the IFS
* Git branch names
* etc

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
2. Add ```External Tools Configurations```
3. Run the build