**free

ctl-opt nomain;

/include 'qcpysrc/sqlsrv1'
// ******************************************************
// Test SQL external procedures
//
// SQL: call prouzat2.sqltest1 ('prouzalib', 'qrpglesrc', '10', '0', '0', '')
// ******************************************************


dcl-proc proc1                    export ;
    dcl-pi *n;
        p_lib                     char(10) const;
        p_srcpf                   char(10) const;
    end-pi;

    exec sql Declare c_members cursor for
        SELECT *
        FROM qsys2.SYSPSTAT
        WHERE table_schema = upper(:p_lib)
        AND table_name = upper(:p_srcpf);

    exec sql open c_members;

    return;

end-proc;

