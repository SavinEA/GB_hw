drop database if exists l3;
create database if not exists l3 character set=utf8mb4;

use l3;
drop table if exists users;
create table if not exists users(
	id serial primary key,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    email varchar(120) unique,
    phone varchar(20) unique,
    bday date,
    hometown varchar(100),
    gender char(1),
    photo_id bigint unsigned,
    create_at datetime default now(),
    pass char(40),
    index phone_idx (phone),
    index users_fio_idx (firstname, lastname)
);

drop table if exists message;
create table if not exists message(
	id serial primary key,
    from_user_id bigint unsigned not null,
    to_user_id bigint unsigned not null,
    message text not null,
    is_read bool default 0,
    created_at datetime default now(),
    foreign key (from_user_id) references users(id),
    foreign key (to_user_id) references users(id)
);

drop table if exists friend_requests;
create table if not exists friend_requests(
	initiator_user_id bigint unsigned not null,
    target_user_id bigint unsigned not null,
    `status` enum('requested', 'approved', 'unfriended', 'declinde'),
    requested_at datetime default now(),
    confirmed_at datetime default current_timestamp on update current_timestamp,
    primary key (initiator_user_id, target_user_id),
    index (initiator_user_id),
    index (target_user_id),
    foreign key (initiator_user_id) references users(id),
    foreign key (target_user_id) references users(id)
);

drop table if exists communities;
create table if not exists communities(
	id serial primary key,
    name varchar(150),
    index (name)     
);

drop table if exists users_communities;
create table if not exists users_communities(
	user_id bigint unsigned not null,
	communities_id bigint unsigned not null,
    primary key (user_id, communities_id),
    foreign key (user_id) references users(id),
    foreign key (communities_id) references communities(id)
);

drop table if exists posts;
create table if not exists posts(
	id serial primary key,
    user_id bigint unsigned not null,
    post text,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    foreign key (user_id) references users(id)
);

drop table if exists comments;
create table if not exists comments(
	id serial primary key,
    user_id bigint unsigned not null,
    post_id bigint unsigned not null,
    comments text,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp on update current_timestamp,
    foreign key (user_id) references users(id),
    foreign key (post_id) references posts(id)    
);

drop table if exists photos;
create table if not exists photos(
	id serial primary key,
    file_name varchar(200),
    user_id bigint unsigned not null,
    `description` text,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(id)    
);

drop table if exists likes;
create table if not exists likes(
	who_like_id bigint unsigned not null,
	whom_like_id bigint unsigned not null,
    message_id bigint unsigned,
    post_id bigint unsigned,
    comment_id bigint unsigned,
    photo_id bigint unsigned,
    foreign key (who_like_id) references users(id),
    foreign key (whom_like_id) references users(id),
    foreign key (message_id) references message(id),
    foreign key (post_id) references posts(id),
    foreign key (comment_id) references comments(id),
    foreign key (photo_id) references photos(id)       
);


