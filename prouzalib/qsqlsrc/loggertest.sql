select * from logger;

select * from logger_hist;

update logger set extref = 'Nix' where extref is null;

select * from logger as of timestamp timestamp('2023-08-22 15:22:42');

values (CURRENT TEMPORAL SYSTEM_TIME);
 
SET CURRENT TEMPORAL SYSTEM_TIME = TIMESTAMP('2023-08-22 15:22:40');

select * from logger;

SET CURRENT TEMPORAL SYSTEM_TIME = null