# Code page problems

## In file names
If you use symbols in object/source names like ```#```, ```$```, ```§``` it's necessary to set your JOB CCSID.

E.g. for german: 
```sh
CHGPRF CCSID(1141)
```

Because builds will be run in a separate job and the job should contain (automatically at start up) the correct CCSID.

## In log files

You can convert the logs to your codepage you want in the ```make/compile_rules.mk``` file.

Just uncomment these variables and change the iconv parameters:
* CONVERT_STDERR_LOG
* CONVERT_STDOUT_LOG
* CONVERT_JOBLOG_LOG