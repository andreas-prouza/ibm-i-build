**free

ctl-opt nomain;
 
/include 'qcpysrc/testmod'
/include 'qcpysrc/logger'

// Only a dummy procedure for testing


dcl-proc testmod export;

    loginfo('This procedure was called');

END-PROC;


