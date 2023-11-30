select * from lager;

select * from lager_hist;

update lager set extref = 'Nix' where extref is null;

select * from lager as of timestamp timestamp('2023-08-22 15:22:42');

values (CURRENT TEMPORAL SYSTEM_TIME);
 
SET CURRENT TEMPORAL SYSTEM_TIME = TIMESTAMP('2023-08-22 15:22:40');

select * from lager;

SET CURRENT TEMPORAL SYSTEM_TIME = null