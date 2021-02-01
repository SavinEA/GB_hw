drop table if exists `logs`;
create table if not exists `logs` (
	log_datetime datetime,
    log_tbl varchar(20),
    tbl_id bigint,
	tbl_name varchar(100)
) engine=archive;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

delimiter //

drop trigger if exists users_log//
create trigger users_log after insert on users
for each row
begin
	insert into `logs`(log_datetime, log_tbl, tbl_id, tbl_name) values(current_timestamp(), 'users', new.id, new.name);
end//

drop trigger if exists catalogs_log//
create trigger catalogs_log after insert on catalogs
for each row
begin
	insert into `logs`(log_datetime, log_tbl, tbl_id, tbl_name) values(current_timestamp(), 'catalogs', new.id, new.name);
end//

drop trigger if exists products_log//
create trigger products_log after insert on products
for each row
begin
	insert into `logs`(log_datetime, log_tbl, tbl_id, tbl_name) values(current_timestamp(), 'products', new.id, new.name);
end//

delimiter ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into users (id, name, birthday_at, created_at, updated_at) values (null, 'Name Name', '2012-02-22', current_date(), current_date());
insert into catalogs (id, name) values (null, 'Catalogs Name');
insert into products (id, name, description, price, catalog_id, created_at, updated_at) values (null, 'Products Name', 'Test description', '1000', 1, current_date(), current_date());

