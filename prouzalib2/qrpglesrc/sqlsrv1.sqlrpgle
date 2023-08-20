**free

ctl-opt nomain;

/include 'qcpysrc/sqlsrv1'
// ******************************************************
// Test SQL external procedures
//
// SQL: call prouzat2.sqltest1 ('prouzalib', 'qrpglesrc', '10', '0', '0', '')
// ******************************************************


dcl-proc proc1                    export;
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

    exec sql open c_members;

    p_sqlcode = sqlcode;

    p_msg = 'SQLCode: ' + %char(sqlcode);

    return;

end-proc;