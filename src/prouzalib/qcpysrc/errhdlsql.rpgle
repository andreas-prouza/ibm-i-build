**free

exec sql Whenever SQLERROR do sqlerror();
exec sql Whenever SQLWARNING do sqlwarning();


dcl-pr sqlerror;
end-pr;

dcl-pr sqlwarning;
end-pr;