**free

/IF NOT DEFINED(PROUZA_STD_COPY)
/DEFINE PROUZA_STD_COPY

// Job-Log output
dcl-pr writeJobLog    int(10)     extproc('Qp0zLprintf');
  message                         pointer value options(*string);
end-pr;

Dcl-C log_ende                    CONST(X'25');




// Run a system command
Dcl-pr system         int(10)     extproc('system');
  cmd                             pointer value options(*string);
End-pr;

dcl-s ErrMsg          char(7)     import('_EXCP_MSGID');


DCL-DS pgm_stat PSDS qualified;
  status *STATUS;
  routine *ROUTINE;
  library CHAR(10) POS(81);
  jobUserNumber char(26) pos(244);
  job char(10) pos(244);
  jobName char(10) pos(244);
  User char(10) pos(254);
  jobUser char(10) pos(254);
  number zoned(6) pos(264);
  jobnumber zoned(6) pos(264);
  jobnumberalpha char(6) pos(264);
  curUser char(10) pos(358);
END-DS;


/ENDIF

