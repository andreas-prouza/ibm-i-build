**free

/include 'qcpysrc/logger'
/include 'qcpysrc/testmod'

/include 'qcpysrc/errhdlsql'


dcl-s l_count   int(10);

// Just to test a procedure call is possible
testmod();

exec sql select count(*) Into :l_count from logger;
logdebug('Number of records: ' + %char(l_count) : 'LOG_TEST_CASE_1');

logerror('Just a jocke, it was not an error :-)' : 'LOG_TEST_CASE_1');


return;
