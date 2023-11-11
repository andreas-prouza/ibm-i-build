# Code page problems

## In file names
If you use symbols in object/source names like ```#```, ```$```, ```§``` it's necessary to set your JOB CCSID.

E.g. for german: 
```sh
CHGPRF CCSID(1141)
```

Add the following settings to you ```.git/config``` file:
```sh
[core]
precomposeunicode = true
quotepath = false
```

Because builds will be run in a separate job and the job should contain (automatically at start up) the correct CCSID.

## In log files

You can convert the logs to your codepage you want in the ```make/compile_rules.mk``` file.

Just uncomment these variables and change the iconv parameters:
* CONVERT_STDERR_LOG
* CONVERT_STDOUT_LOG
* CONVERT_JOBLOG_LOG


# Compile problems

## Continue dependencies in the chain after a broken compile
Imagine you change a DB object that depends on many objects.

Now, during the compilation process some objects (including the DB object) were built successfully, but one program fails.

When you restart the build process, 'make' automatically detects that there are still some missing dependent objects that need to be compiled.