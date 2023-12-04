**free

exec sql Whenever SQLERROR do errhdlsqlp();
exec sql Whenever SQLWARNING do errhdlsqlp();

dcl-pr errhdlsqlp    extpgm('ERRHDLSQLP');
end-pr;
