**free

ctl-opt main(main);


// ******************************************************
// Test SQL external procedures 
//
// SQL: call prouzat2.sqltest1 ('prouzalib', 'qrpglesrc', '10', '0', '0', '')
// ******************************************************


dcl-proc main;
    dcl-pi *n;
        p_lib                     char(10) const;
        p_srcpf                   char(10) const;
        p_test                    int(10);
        p_number_of_members       int(10);
        p_sqlcode                 int(10);
        p_msg                     char(200);
    end-pi;

    clear p_number_of_members;

    exec sql 
        SELECT count(*) Into :p_number_of_members
        FROM qsys2.SYSPSTAT
        WHERE table_schema = upper(:p_lib)
        AND table_name = upper(:p_srcpf);

    p_sqlcode = p_test + sqlcode;

    p_msg = 'SQLCode: ' + %char(sqlcode);

    return;

end-proc;