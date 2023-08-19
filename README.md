# Documentation

- [Overview](/docs/pages/overview.md)
- [Quick Start](/docs/pages/quick_start.md)
- [SSH](/docs/pages/SSH.md)
- [GNU Make](/docs/pages/gnu_make.md)
- [Integration in your IDE](/docs/pages/integration_in_your_ide.md)
- [FAQ](/docs/pages/faq.md)


# 

**This project should help to make our deployment process automated:**

## Features
* Check for changes
  
    Check all sources which have changed since last compilie
  
* Check for dependencies
  
  Compile in addition all objects which depend on the changed source

  E.g. if a table or view has changed, compile also all programms which use them

  In the following example the program ```mypgm``` depends on these objects:
  ```
  prouzalib/mypgm.sqlrpgle.pgm: \
    prouzalib/logger.sqlrpgle.srvpgm \
    prouzalib/errhdlsql.sqlrpgle.srvpgm \
    prouzalib/date.rpgle.srvpgm \
    prouzalib/myfile.pf.file \
    prouzalib/myview.sqlview.file

  ```

* Compile in correct order
  
  tables before programs etc. based on dependency list

* All actions can be done in you IDE (RDi or vscode)

  ![run-command-2.jpg](docs/assets/run-command-2.jpg)

* Logging
  
  All compile informations seperated by each source: joblog, spool file, error output

  ![compile-logs](docs/assets/compile-logs.jpg)


**If you also want to use git with that you will benefit of all it advantages:**

* Work with branches
* Version control

  ![git-commit](docs/assets/git-commit.jpg)

* Integration in other tools like Atlassian JIRA
* Compare between different versions

  ![git-compare](docs/assets/git-compare.jpg)


***Best practice***

Disable ```logs``` and ```build``` dir to synch with remote repository.

This is only necessary for build servers.

```sh
git update-index --assume-unchanged build/compile.sh
git update-index --assume-unchanged build/objects.txt
git update-index --assume-unchanged build/prod_obj.txt
git update-index --assume-unchanged build/{you-lib}/*

git update-index --assume-unchanged logs/{you-lib}/*
```

Exclude them in ```{you-dir}/.git/info/exclude```
```sh
logs/***
build/***
```