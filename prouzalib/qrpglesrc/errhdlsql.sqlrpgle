**free
ctl-opt nomain;



// No commitment control because we never want to ROLLBACK anything in a Logger!
exec sql Set Option COMMIT=*none;

/include 'qcpysrc/logger'
/include 'qcpysrc/errhdlsql'



dcl-proc sqlerror                 export;

  handle_sql('Error');
  return;

end-proc;



dcl-proc sqlwarning               export;

  handle_sql('Warning');
  return;

end-proc;



dcl-proc handle_sql;
  dcl-pi *n;
    p_type                        varchar(10) const;
  end-pi;

  dcl-s l_msgtext                 varchar(1000);
  dcl-s l_msgid                   char(7);
  dcl-s l_sqlcode                 like(sqlcode) inz(0);
  dcl-s l_sqlstate                like(sqlstate) inz('');

  Exec sql GET DIAGNOSTICS CONDITION 1
             :l_msgtext  = MESSAGE_TEXT,
             :l_msgid    = DB2_MESSAGE_ID,
             :l_sqlcode  = DB2_RETURNED_SQLCODE,
             :l_sqlstate = RETURNED_SQLSTATE;

  logerror('SQL ' + p_type + ' (' + %char(l_sqlcode) + '/' + l_sqlstate + '): ' + l_msgtext);

  Send_Program_Message(l_msgtext : '*ESCAPE' : l_msgid : 'QSQLMSG');

  return;

end-proc;