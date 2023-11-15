**free

ctl-opt main(main);


// ******************************************************
// Test SQL external procedures
//
// SQL: call prouzat2.sqltest2 ('prouzalib', 'qrpglesrc', '0', '')
// ******************************************************


dcl-proc main;
    dcl-pi *n;
        p_lib                     char(10) const;
        p_srcpf                   char(10) const;
        p_sqlcode                 int(10);
        p_msg                     char(200);
    end-pi;

    exec sql Declare c_members cursor for
        SELECT *
        FROM qsys2.SYSPSTAT
        WHERE table_schema = upper(:p_lib)
        AND table_name = upper(:p_srcpf);

    exec sql Declare c_logger cursor for
        SELECT *
        FROM prouzalib.logger
        order by id desc;

    exec sql open c_members;
    exec sql open c_logger;

    p_sqlcode = sqlcode;
    p_msg = 'SQLCode: ' + %char(sqlcode);

    return;

end-proc;