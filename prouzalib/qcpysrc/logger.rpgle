**free

/IF NOT DEFINED(PROUZA_LOGGER_COPY)
/DEFINE PROUZA_LOGGER_COPY

  dcl-c  C_LOG_DEBUG              'DEBUG';
  dcl-c  C_LOG_INFO               'INFO';
  dcl-c  C_LOG_WARNING            'WARNING';
  dcl-c  C_log_ERROR              'ERROR';

  dcl-ds logger_ds_tmp            extname('LOGGER') alias qualified template;
  END-DS;

  dcl-pr log;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PR;

  dcl-pr loginfo;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PR;

  dcl-pr logdebug;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PR;

  dcl-pr logwarning;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PR;

  dcl-pr logerror;
    p_text                        like(logger_ds_tmp.text) const;
    p_extref                      like(logger_ds_tmp.extref) const options(*nopass);
    p_program                     like(logger_ds_tmp.program) const options(*nopass);
    p_print2Joblog                ind const options(*nopass);
  END-PR;

  dcl-pr IBMAPI_Send_Program_Message  extpgm('QMHSNDPM');
    MsgID              char(7)      const;
    MsgFile            char(20)     const;
    MsgDta             char(32767)  const   options(*varsize);
    MsgDtaLen          int(10)      const;
    MsgType            char(10)     const;
    MsgQ               char(10)     const;
    MsgQNbr            int(10)      const;
    MsgKey             char(4);
    ErrorDs            likeds(ErrorDS);
  end-pr;

  dcl-pr Send_Program_Message;
    p_msg                         varchar(1000) const;
    p_type                        varchar(10)   const;
    p_msgid                       char(7)       const options(*nopass);
    p_msgf                        char(10)      const options(*nopass);
    p_msgf_lib                    char(10)      const options(*nopass);
    p_log                         ind           const options(*nopass);
  END-PR;

  Dcl-ds ErrorDS       qualified inz;
    BytesProv          int(10) inz(0);
    BytesAvail         int(10) inz(0);
  end-ds;

  Dcl-s ProgramMsgKey  char(4) inz;


/ENDIF
