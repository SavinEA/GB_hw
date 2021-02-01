-- Lesson 6
-- Home work
-- 1) Проанализировали, все понятно, идем дальше)))

-- 2) Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

select
	users.id, users.firstname, users.lastname, count(messages.message) as count, messages.from_user_id, messages.to_user_id
from users join messages
on
	users.id=messages.from_user_id
where
	users.id in (
		select initiator_user_id from friend_requests where target_user_id = 44 and status = 'approved'
		union
		select target_user_id from friend_requests where initiator_user_id = 44 and status = 'approved')
group by
	users.id
order by
	count desc limit 1;

-- 3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select
	users.id, users.firstname, users.lastname, users.birthday, count(likes_posts.user_id) as likes
from users join likes_posts
on
	users.id=likes_posts.user_id
group by
	users.id
order by
	users.birthday desc limit 10;

-- 4) Определить кто больше поставил лайков (всего) - мужчины или женщины?

select
	users.gender, count(likes_posts.user_id) as likes
from users join likes_posts
on
	users.id=likes_posts.user_id
group by
	users.gender
order by
	likes desc limit 1;

-- 5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

select
	id,
    firstname,
    lastname,
    (select count(message) from messages where from_user_id=users.id) as messages,
    (select count(post) from posts where user_id=users.id) as posts,
    (select count(filename) from photos where user_id=users.id) as photos
from
	users
order by
	posts desc, photos desc, messages desc limit 10;




