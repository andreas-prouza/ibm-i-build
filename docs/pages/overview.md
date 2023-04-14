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