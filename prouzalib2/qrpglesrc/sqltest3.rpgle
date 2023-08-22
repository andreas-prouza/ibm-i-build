**free
ctl-opt nomain;

// ******************************************************
// Test SQL external procedures
//
// SQL: call prouzat2.sqltest2 ('prouzalib', 'qrpglesrc', '0', '')
// ******************************************************


dcl-proc get_text                 export;
    dcl-pi *n                     char(50);
        p_text                    char(10) const;
    end-pi;

    return 'Der Text ist ' + %char(%len(%trim(p_text))) + ' lang';

end-proc;