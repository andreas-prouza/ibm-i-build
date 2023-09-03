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
* [GNU Make](gnu_make.md#gnu-make) to create compile commands
  * Install it on IBM i
* Your prefered IDE (RDi or VSCode)
* [SSH](SSH.md#ssh) with key based authentication
* for [Windows](integration_in_your_ide.md#windows) you need one of these:
  * Windows Subsystem for Linus (WSL)
  * or Cygwin
* for [Linux](integration_in_your_ide.md#linux) install
  * ```rsync```
  * ```make```
  * ```jq```


## Change build settings

### [Adapt build settings](gnu_make.md#set-up-your-build-settings)
Modify makefiles to your own settings
   * ```./makefile```
     * IFS Path
     * Target lib (PGM, DB, ...)
     * ACTGRP
     * LIBLIST
   * ```make/object_list.mk```
     * Objects to be build
     * Dependencies between objects
   * ```make/.makeprofile.mk```
     * If you want to override some settings for your own environment
     * This file should be in the ```.gitignore``` file, so it's not synchronized

### [Adapt global settings](gnu_make.md#global-settings)

```make/global.cfg```
* Target system (IBM i)
* Directory in the IFS
* Git branch names
* etc

## [Initiate your dummy build files](gnu_make.md#prepare-for-first-build)


## VSCode as IDE

1. Install [VSCode extensions](integration_in_your_ide.md#vscode-extensions)
2. Open the project directory in vscode
3. Rename the ```.vscode/settings.json``` from the Windows or Linux template <br/>
   See [Project settings](integration_in_your_ide.md#project-settings)
4. [Just run the build](integration_in_your_ide.md#lets-run-the-build)

## RDi as IDE

1. Import the Git Repo as new project
2. Add ```External Tools Configurations```
3. Run the build