set echo on
connect system/amakal

--create php application user
drop user phpuser cascade;
create user phpuser identified by welcome;
	grant connect, resource to phpuser;
		alter user phpuser default tablespace users
		temporary tablespace temp account unlock;

		--create user owner security information about the app
		drop user php_sec_admin cascade;
		create user php_sec_admin identified by welcome;
			alter user php_sec_admin default tablespace system temporary tablespace temp account unlock;
			grant create procedure,create session, create table, resource, select any dictionary to php_sec_admin;


				connect phpuser/welcome
				--"parts" table for the application demo
				create table parts
					(id number primary key,category varchar2(20),name varchar2(20));
					insert into parts	values (1,'electrical','lamp');
						insert into parts	values (2,'electrical','wire');
							insert into parts	values (3,'electrical','switch');
								insert into parts	values (4,'plumbing','pipe');
									insert into parts	values (5,'plumbing','sink');
										insert into parts	values (6,'plumbing','toilet');
											connect php_sec_admin/welcome;
											--authentication table woth the web user name &passwords
											--a real application would never store plain text passwords
											-- but this code is a demo for client identifiers and not about authentication
											create table php_authentication
												(app_username varchar2(20) primary key,
													app_password varchar2(20) not null);

												insert into php_authentication values ('mirana','tiger');
													insert into php_authentication values ('luna','leopard');
														commit;
														grant select on php_authentication to phpuser;




