-- Lesson 9
-- Home work

-- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

start transaction;
set @id = (select id from shop.users where users.id=1);
set @name = (select name from shop.users where users.id=1);
set @birthday_at = (select birthday_at from shop.users where users.id=1);
set @created_at = (select created_at from shop.users where users.id=1);
set @updated_at = (select updated_at from shop.users where users.id=1);
INSERT INTO sample.users (id, name, birthday_at, created_at, updated_at) VALUES (@id, @name, @birthday_at, @created_at, @updated_at);
commit;

-- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

drop view if exists show_name;
CREATE VIEW show_name AS SELECT products.name as p_name, catalogs.name as c_name FROM products, catalogs where products.catalog_id = catalogs.id;
select * from show_name;

-- 3) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

drop table if exists august_dates; 
create table if not exists august_dates (
	id serial primary key,
    created_at date
);

insert into august_dates (id, created_at) values (null, '2020-08-01');
insert into august_dates (id, created_at) values (null, '2020-08-04');
insert into august_dates (id, created_at) values (null, '2020-08-16');
insert into august_dates (id, created_at) values (null, '2020-08-17');

create view test as SELECT * FROM 
(SELECT adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) aug_date FROM
 (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) massiv
WHERE aug_date BETWEEN '2020-08-01' AND '2020-08-31';


select test.aug_date,
case
	when test.aug_date=august_dates.created_at
		then '1'
	else '0'
end as check_in
from test, august_dates;

-- в общем что-то пошло не так, времени остается мало придется пропустить доп задания =(
-- на праздничных выходных, если не вызовут на работу, постраюсь доделать))

-- 4) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.






