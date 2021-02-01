drop database if exists shop;
create database if not exists shop;
use shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';



-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»

-- 1
alter table users					-- меняем тип данных и настройки по умолчанию, для избежания проблем с незаполненными полями в будующем
	modify created_at datetime default current_timestamp,
    modify updated_at datetime default current_timestamp on update current_timestamp;

SET SQL_SAFE_UPDATES = 0;			-- отключаем софт апдейт															
update users						-- обновляем данные в таблице и записываем сегодняшнее число
	set 
		created_at = now(),
		updated_at = now();
SET SQL_SAFE_UPDATES = 1;			-- включаем софт апдейт

-- 2
truncate users;						-- очищаем таблицу users для удобства работы

alter table users					-- меняем тип данных на varchar, согласно условия задачи													
	modify created_at varchar(50),
    modify updated_at varchar(50);
 
insert users values					-- заполняем таблицу тестовыми данными
(null, 'qwerty', current_date(), '20.10.2017 8:10', '20.10.2017 8:10'),
(null, 'asdfgh', current_date(), '22.11.2015 7:11', '22.11.2015 7:11'),
(null, 'zxcvbn', current_date(), '10.12.2016 9:12', '20.10.2017 9:12');

SET SQL_SAFE_UPDATES = 0;
-- обновляем данные в таблице, согласно заданного формата даты '%d\.%m\.%Y %h\:%i'
update users set created_at=str_to_date(created_at, '%d\.%m\.%Y %h\:%i'), updated_at=str_to_date(updated_at, '%d\.%m\.%Y %h\:%i');	
SET SQL_SAFE_UPDATES = 1;
	
 alter table users					-- меняем тип данных и настройки по умолчанию, для избежания проблем с незаполненными полями в будующем
	modify created_at datetime default current_timestamp,
    modify updated_at datetime default current_timestamp on update current_timestamp;
 
-- 3
insert storehouses_products values	-- заполняем таблицу тестовыми данными
(null, 15, 21, 0, current_date(), current_date()),
(null, 23, 23, 1, current_date(), current_date()),
(null, 32, 43, 4, current_date(), current_date()),
(null, 51, 64, 3, current_date(), current_date()),
(null, 52, 62, 0, current_date(), current_date()),
(null, 124, 232, 0, current_date(), current_date()),
(null, 41, 52, 30, current_date(), current_date()),
(null, 15, 27, 20, current_date(), current_date()),
(null, 41, 72, 40, current_date(), current_date()),
(null, 21, 21, 0, current_date(), current_date());
																					-- сортируем значения:
select * from storehouses_products order by if (value>0, 1, 0) desc, value asc;		-- если больше 0, то сортируем по порядку, если 0 то сортируем по убиыванию 
select * from storehouses_products order by if (value = 0, ~0, value);				-- если =0, то присваиваем ~0 (самое большое число), если !=0 то берем текущее значение, после чего все соритруем по возрастанию

-- 4*
truncate users;		

insert into users (name, birthday_at, created_at)		-- заполняем данными из другой БД
select firstname, bday, create_at from users.users
order by bday;

-- выбираем имя, дату рождения, и месяц даты рождения. отбираем только поля, где месяц май(05) или август (08)
select name, birthday_at, date_format (birthday_at, '%M') as `month` from users where month(birthday_at) = 05 or month(birthday_at) = 08;

-- 5*
-- выбираем все значения таблцы, согласно условия. сортируем по принципу. если !=5, то присваиваем самомому большому числу и все сортируем по возрастанию
SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by if (id!=5, ~0, id);

-- Практическое задание теме «Агрегация данных»

-- 1
-- берем среднее значение разницы года текущей даты и года даты рождения и округляем до целых
select floor(avg(year(current_date()) - year(birthday_at))) as AVG_age from users;

-- воспользуемся функцией datediff и найдем разницу дней между текущей датой и днем рождения, поделим на 365.25 (дней в году с поправкой на весокосный год). найдем среднее и округлим
select floor(avg(datediff(current_date(), birthday_at)/365.25)) as AVG_age from users;

-- 2
-- выбираем дни недели из даты рождения и суммируем по каждому дню, сортируем по индексу дня недели (0-6)
select dayname(birthday_at) as bday_day, count(dayname(birthday_at)) as bday_count from users group by bday_day order by weekday(birthday_at);

-- составляем дату из 2020 года и месяца с днем даты рождения. далее как описано выше
select 
dayname(concat(year(current_date()), date_format(birthday_at, '-%m-%d'))) as bday_day, 
count(concat(year(current_date()), date_format(birthday_at, '-%m-%d'))) as bday_count 
from users 
group by bday_day 
order by weekday(concat(year(current_date()), date_format(birthday_at, '-%m-%d')));

-- 3
-- експонента равна суммме логарифмов, считаем и округляем вверх 
select round(exp(sum(log(id)))) as proisvedeniye from catalogs;



 
