**free

ctl-opt main(main) bnddir('PROUZADIR');

exec sql Set Option COMMIT=*none;

/include 'qcpysrc/logger'
/include 'qcpysrc/errhdlsql'


dcl-proc main;

  dcl-s l_count                     int(10);

  loginfo('My PGM starts ...' : 'LOG_TEST_CASE_2');
  
  // SQL error will be issued here:
  exec sql Select count(*) Into :l_count from doesnt_exist;

  loginfo('Number of records: ' + %char(l_count) : 'LOG_TEST_CASE_2');

  return;

end-proc;

