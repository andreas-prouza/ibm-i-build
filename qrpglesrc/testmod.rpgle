**free

ctl-opt nomain;
 
/include 'qcpysrc/c_testmod'
/include 'qcpysrc/c_logger'

// Only a dummy procedure for testing

dcl-proc testmod export;

    loginfo('This procedure was called');

END-PROC;


