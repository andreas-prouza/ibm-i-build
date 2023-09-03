# Overview

My DevOps concept includes multiple components like Git as a basis for source management.

In this example, I focus on the build part of the DevOps concept including Git.

For all IBM i builds I use the following components:

* GNU Make
  
  Builds your sources (or at least creates the build commands) ...

  * in correct order
  * and considers dependencies (PF/LF/DSPF --> RPG)
  
* IDE: VSCode or RDi
  
* RSYNC
  
  To synchronize your sources to the IFS of the build server (IBM i)<br/>
  Yes, all sources are in folder and not in source files.<br/>
  This has many advantages, later more about this.