- [Quick Start](#quick-start)
    - [Prerequesits](#prerequesits)
    - [Without IDE](#without-ide)
    - [With VSCode as IDE](#with-vscode-as-ide)


# Quick Start

### Prerequesits
* To be able to compile the source on IBM i
  * [GNU Make](gnu_make.md#gnu-make) is installed on IBM i
* To be able to work with your prefered IDE
  * [SSH](SSH.md#ssh) is working well on you local computer
  * for [Windows](integration_in_your_ide.md#windows)
    * Windows Subsystem for Linus (WSL) is installed
  * for [Linux](integration_in_your_ide.md#linux)
    * ```rsync``` is installed
    * ```make``` is installed
    * ```jq``` is installed
  * [VSCode extensions](integration_in_your_ide.md#vscode-extensions) if you use vscode

### Without IDE
If you only want to compile on your machine without any IDE:<br/>
Proceed the [Summary](gnu_make.md#summary)

### With VSCode as IDE
1. Rename the ```.vscode/settings.json``` from the Windows or Linux template
2. [Adapt the makefiles](gnu_make.md#set-up-your-makefiles) to your environment
  * source location
  * target object lib
  * LIBLIST
  * ACTGRP
  * etc.
3. [Just run the build](integration_in_your_ide.md#lets-run-the-build)