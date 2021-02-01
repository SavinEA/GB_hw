-- Lesson 7
-- Home work
-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select
	users.id, users.name, count(orders.id) as orders 
from 
	users join orders
on
	users.id=orders.user_id
group by
	users.id;

-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

select
	products.name, products.description, catalogs.name
from
	products join catalogs
on
	catalogs.id=products.catalog_id;

-- 3) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

create table flights (
	id serial primary key,
    `from` varchar(50),
    `to`  varchar(50)
);

INSERT INTO flights (id, `from`, `to`) VALUES (null, 'moscow', 'omsk');
INSERT INTO flights (id, `from`, `to`) VALUES (null, 'novgorod', 'kazan');
INSERT INTO flights (id, `from`, `to`) VALUES (null, 'irkutsk', 'moscow');
INSERT INTO flights (id, `from`, `to`) VALUES (null, 'omsk', 'irkutsk');
INSERT INTO flights (id, `from`, `to`) VALUES (null, 'moscow', 'kazan');

create table cities (
	`label` varchar(50),
    `name`  varchar(50),
    unique (label)
);

INSERT INTO cities (`label`, `name`) VALUES ('moscow', 'Москва');
INSERT INTO cities (`label`, `name`) VALUES ('irkutsk', 'Иркутск');
INSERT INTO cities (`label`, `name`) VALUES ('novgorod', 'Новгород');
INSERT INTO cities (`label`, `name`) VALUES ('kazan', 'Казань');
INSERT INTO cities (`label`, `name`) VALUES ('omsk', 'Омск');

select
	f.id,
	f.from,
    f.to,
    c1.name as from_rus,
    c2.name as to_rus
  from 
	flights as f
  left join
	cities as c1 on c1.label = f.from
  left join
	cities as c2 on c2.label = f.to;
