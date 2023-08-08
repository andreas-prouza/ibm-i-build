# Code page problems

If you use symbols in object/source names like ```#```, ```$```, ```§``` it's necessary to set your JOB CCSID.

E.g. for german: 
```sh
CHGPRF CCSID(1141)
```

Because builds will be run in a separate job and the job should contain (automatically at start up) the correct CCSID.