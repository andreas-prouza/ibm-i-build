**free
ctl-opt main(main);


/copy 'qcpysrc/errhdlsql'


// ******************************************************
// Copy all source files from a LIB to IFS
// ******************************************************



Dcl-pr system                     int(10) extproc('system');
  cmd                             pointer value options(*string);
End-pr;

dcl-s ErrMsg                      char(7) import('_EXCP_MSGID');

// Job-Log output
dcl-pr writeJobLog                int(10) extproc('Qp0zLprintf');
  message                         pointer value options(*string);
end-pr;

Dcl-C log_ende                    CONST(X'25');


dcl-proc main;
    dcl-pi *n;
        p_lib                     char(10) const;
        p_root_dir                char(100) const;
    end-pi;

    dcl-s l_lib varchar(10);
    dcl-s l_file varchar(10);
    dcl-s l_file_tmp varchar(10);
    dcl-s l_mbr varchar(10);
    dcl-s l_ext varchar(10);

    dcl-s l_cmd      varchar(500);
    dcl-s l_root_dir varchar(100);
    dcl-s l_cur_dir      varchar(100);

    exec sql Declare c_cpy cursor for
        SELECT table_schema, lower(table_name), lower(table_partition),
                lower(source_type)
        FROM qsys2.SYSPSTAT
        WHERE table_schema = :p_lib
        AND source_type IS NOT NULL
        AND source_type NOT IN ('TXT')
        and table_partition <> '';

    writeJobLog ('Start' + log_ende);


    exec sql open c_cpy;
    exec sql fetch c_cpy into :l_lib, :l_file, :l_mbr, :l_ext;

    l_root_dir= %trim(p_root_dir) + '/' + 
                %char(%timestamp(*SYS : 0) : *ISO) + '/' + 
                %trim(p_lib);

    // Create directory and all it's parent folders if not exist
    l_cmd = 'QSH cmd(''mkdir -p ' + l_root_dir + ''')';
    writeJobLog (l_cmd + log_ende);
    system(l_cmd);

    dow sqlcode = 0;

    if (l_file <> l_file_tmp);
        l_file_tmp = l_file;
        l_cur_dir = l_root_dir + '/' + l_file;
        l_cmd = 'mkdir ''' + l_cur_dir + '''';
        writeJobLog (l_cmd + log_ende);
        system(l_cmd);
        l_cmd = 'CHGATR OBJ(''' + l_cur_dir + ''') ATR(*CCSID) VALUE(1208)';
        writeJobLog (l_cmd + log_ende);
        system(l_cmd);
    ENDIF;

    l_cmd = 'CPYTOSTMF FROMMBR(''/QSYS.LIB/' + %trim(p_lib) + '.LIB/' + 
                    l_file + '.FILE/' +
                    l_mbr + '.MBR'') STMFCCSID(1208) +
                TOSTMF(''' + l_cur_dir + '/' + l_mbr + '.' + l_ext + ''')';
    clear ErrMsg;
    system (l_cmd);

    if (ErrMsg <> '');
        writeJobLog ('Error in Command: ' + ErrMsg + log_ende);
        writeJobLog (l_cmd + log_ende);
        return;
    ENDIF;

    exec sql fetch c_cpy into :l_lib, :l_file, :l_mbr, :l_ext;
    ENDDO;

    exec sql close c_cpy;

    return;

end-proc;