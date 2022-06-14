**free
ctl-opt nomain;

/include 'QCPYSRC/C_STD'
/include 'qcpysrc/c_logger'

// No commitment control because we never want to ROLLBACK anything in a Logger!
exec sql Set Option COMMIT=*none;


//--------------------------------------------------------------
// Log data to logger table
//
// Parameter:  - Text
//
//             - External Reference (Optional)
//                 Just any key for you for better researching of log entries
//
//             - Program (Optional)
//                 Program name of caller
//                 If not passed, it will be retrieved automatically
//
//             - Print2Joblog (Optional)
//                 *ON: The text will be written to the joblog
//                 *OFF: (Default) Data will not be written to the joblog
//--------------------------------------------------------------

dcl-proc logging export;

  dcl-pi *n;
    p_loglevel                    like(logger_ds_tmp.loglevel) const;   
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  dcl-s l_text                    like(logger_ds_tmp.text) inz;

  dcl-s l_extref                  like(logger_ds_tmp.extref) inz;
  dcl-s i_EXTREF                  int(5) inz(-5);

  dcl-s l_program                 like(logger_ds_tmp.program) inz;


  l_text = %trim(p_text);

  if (%parms >= %Parmnum(p_extref));
    l_extref = %trim(p_extref);
    i_EXTREF = 0;
  endif;

  if (%parms >= %Parmnum(p_program));
    l_program = %trim(p_program);
  else;
    Exec Sql Select
            Program_Library_name || '/' ||
            Program_name || '(' || coalesce(Procedure_name, '*none') || ')'
          Into :l_program
          From table(qsys2.stack_info()) t1
          Where Program_library_name not like 'Q%'
          and   Program_name <> 'LOGGERM'
          Order by ordinal_position desc
          Fetch first Row Only;
  ENDIF;

  Exec Sql Insert Into prouzalib.Logger(loglevel, text, extref, program) 
          values (:p_loglevel, :l_text, :l_extref :i_EXTREF, :l_program);

  if (%parms >= %Parmnum(p_print2Joblog) and p_print2Joblog);
    writeJobLog (l_text + log_ende);
  endif;

END-PROC;


dcl-proc log export;

  dcl-pi *n;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  if (%parms >= %Parmnum(p_print2Joblog));
    logging(C_LOG_INFO : p_text : p_program : p_print2Joblog);
  elseif (%parms >= %Parmnum(p_program));
    logging(C_LOG_INFO : p_text : p_program);
  else;
    logging(C_LOG_INFO : p_text);
  endif;

END-PROC;


dcl-proc logdebug export;

  dcl-pi *n;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  if (%parms >= %Parmnum(p_print2Joblog));
    logging(C_log_DEBUG : p_text : p_extref : p_program : p_print2Joblog);
  elseif (%parms >= %Parmnum(p_program));
    logging(C_log_DEBUG : p_text : p_extref: p_program);
  elseif (%parms >= %Parmnum(p_extref));
    logging(C_log_DEBUG : p_text : p_extref);
  else;
    logging(C_log_DEBUG : p_text);
  endif;

END-PROC;



dcl-proc loginfo export;

  dcl-pi *n;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  if (%parms >= %Parmnum(p_print2Joblog));
    logging(C_log_INFO : p_text : p_extref : p_program : p_print2Joblog);
  elseif (%parms >= %Parmnum(p_program));
    logging(C_log_INFO : p_text : p_extref: p_program);
  elseif (%parms >= %Parmnum(p_extref));
    logging(C_log_INFO : p_text : p_extref);
  else;
    logging(C_log_INFO : p_text);
  endif;

END-PROC;



dcl-proc logwarning export;

  dcl-pi *n;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  if (%parms >= %Parmnum(p_print2Joblog));
    logging(C_log_WARNING : p_text : p_extref : p_program : p_print2Joblog);
  elseif (%parms >= %Parmnum(p_program));
    logging(C_log_WARNING : p_text : p_extref: p_program);
  elseif (%parms >= %Parmnum(p_extref));
    logging(C_log_WARNING : p_text : p_extref);
  else;
    logging(C_log_WARNING : p_text);
  endif;

END-PROC;



dcl-proc logerror export;

  dcl-pi *n;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PI;

  if (%parms >= %Parmnum(p_print2Joblog));
    logging(C_log_ERROR : p_text : p_extref : p_program : p_print2Joblog);
  elseif (%parms >= %Parmnum(p_program));
    logging(C_log_ERROR : p_text : p_extref: p_program);
  elseif (%parms >= %Parmnum(p_extref));
    logging(C_log_ERROR : p_text : p_extref);
  else;
    logging(C_log_ERROR : p_text);
  endif;

END-PROC;

//--------------------------------------------------------------
// Send Program Message
//
// Parameter:  Message
//             
//             Type
//                *ESCAPE for Excape messages
//
//             Log
//                Optional
//                *ON: Message will be written to the Logger table
//                *OFF: (Default) will not be written to Logger
//--------------------------------------------------------------

dcl-proc Send_Program_Message export;
  dcl-pi *n;
    p_msg      varchar(1000) const;
    p_type     varchar(10)   const;
    p_log      ind           const options(*nopass);
  END-PI;

  if (%parms < %parmnum(p_log) Or p_log = *on);
    log('Send_Program_Message (' + %trim(p_type) + '): ' +
         %trim(p_msg));
  endif;

  IBMAPI_Send_Program_Message('CPF9897' : 'QCPFMSG   *LIBL' :
                     p_msg : %len(%trim(p_msg)) :
                     p_type : '*PGMBDY' :
                     1 : ProgramMsgKey : ErrorDS );

END-PROC;
