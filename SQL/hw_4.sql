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

set foreign_key_checks = 0;

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('1', '1', '1', 'Qui quis qui possimus dolor vero. Dolor officia totam et et temporibus. Maxime adipisci earum placeat hic eum quas et.', '2016-11-23 06:16:53', '2011-10-01 22:25:00');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('2', '2', '2', 'Quo impedit corporis officia natus qui odit. Adipisci iure dolorum et delectus omnis est et. Suscipit aliquid temporibus quam est delectus ut fugiat quae. Dolorum non amet ab ut expedita non architecto.', '1992-03-19 19:37:35', '2012-07-05 21:04:33');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('3', '3', '3', 'Aspernatur nihil unde nemo. Delectus quo aut aut illo maxime. Nobis nulla corrupti rem doloremque et ipsa ipsam.', '1986-08-28 12:59:24', '1971-04-27 17:24:50');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('4', '4', '4', 'Iste animi aspernatur quis ullam delectus. Voluptatem odio doloribus enim est.', '2002-08-12 05:40:07', '1983-02-25 12:42:11');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('5', '5', '5', 'Est similique eveniet ut et maiores. Exercitationem distinctio ipsa minus quo molestiae officiis. Eveniet iusto doloribus dolor pariatur sit. Aut accusantium et corrupti deserunt.', '2015-02-02 23:10:39', '1978-02-16 14:07:00');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('6', '6', '6', 'Quia quam quasi aut. Nisi voluptas a ea voluptatem. Sed alias sed animi ex. Aliquid perferendis quod animi beatae nostrum ipsam.', '1997-05-07 15:17:09', '1985-01-16 05:35:07');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('7', '7', '7', 'Blanditiis qui quae iure sapiente at. Aspernatur atque consectetur quo corporis ut vel laborum.', '2012-06-09 12:02:30', '1987-08-23 14:40:11');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('8', '8', '8', 'Et maiores laboriosam vel consectetur. Laboriosam voluptatum non sed eum aut. Culpa assumenda id officiis ea.', '1996-04-28 14:31:54', '1992-02-19 21:01:41');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('9', '9', '9', 'Ab et consequatur fugiat ut autem quia. Quae inventore odio consequatur expedita laborum. Quidem tempora sit optio accusamus. Reprehenderit quae voluptate quidem. Vero aperiam quidem officiis repudiandae.', '2005-01-25 02:20:00', '2008-01-31 18:44:49');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('10', '10', '10', 'Doloribus repellat nisi qui ea nulla eum. Consequatur adipisci sequi assumenda nostrum. Quibusdam nesciunt et qui animi voluptatum velit eaque aut.', '1980-04-24 04:28:37', '1995-04-25 13:24:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('11', '11', '11', 'Et exercitationem ut aperiam ipsam laboriosam suscipit. Dolores voluptatem autem dolorem a ducimus optio sit. Magni corrupti aut harum aut officiis maiores.', '2006-11-23 08:35:55', '1990-08-10 12:19:13');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('12', '12', '12', 'Culpa modi consequatur velit ipsa maiores aperiam et. Quas ut aut quia.', '1975-04-11 16:46:28', '2002-05-18 07:20:04');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('13', '13', '13', 'Consequatur maiores nulla eveniet reiciendis. Sit perspiciatis et enim quasi dolore. Voluptatem sit necessitatibus ut voluptate et voluptates itaque.', '1999-10-14 22:30:41', '2004-07-14 11:58:10');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('14', '14', '14', 'Qui atque magni eveniet voluptas quo. Nihil odio consequatur in sint rerum aut fuga. Beatae autem sunt officia dignissimos sequi neque nobis eum. Quam fugiat similique odit similique et.', '1991-11-15 02:20:10', '1984-07-03 18:51:44');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('15', '15', '15', 'Placeat non a iste molestiae dolorem. Odio impedit porro molestiae similique. Soluta consectetur quod sed corporis quia consequatur.', '1985-11-15 09:24:45', '1977-06-21 03:45:06');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('16', '16', '16', 'Ut ab voluptas a aut similique architecto. Minus suscipit corporis architecto quos aperiam sunt. Rem sint ab et eveniet dolorem sunt est voluptate.', '1970-02-11 01:02:27', '1993-05-22 09:29:06');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('17', '17', '17', 'Totam vero est harum numquam. Ipsam delectus aut reprehenderit facere velit beatae qui. Quod et iure et qui.', '2014-06-01 01:18:41', '1976-12-22 04:05:41');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('18', '18', '18', 'Iusto at odio velit qui consectetur aut. Error minus natus ut dolores. Sapiente aut adipisci consequatur laborum est.', '1996-09-10 16:04:30', '2014-11-23 11:47:25');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('19', '19', '19', 'Ut laboriosam quidem natus voluptatibus non occaecati. Atque possimus rerum dolorem et officiis sunt quia. Aut vel enim animi dolorum. Voluptates aspernatur sit vel alias.', '2014-07-26 16:31:00', '1995-04-18 19:30:07');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('20', '20', '20', 'Voluptatem est voluptatum similique rerum. Magnam quibusdam tempora alias sit ipsam omnis ea non. Ducimus facere tempore eos quis eligendi omnis.', '1996-04-17 08:26:56', '2019-08-23 13:13:55');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('21', '21', '21', 'Modi error atque dolor voluptatem perferendis exercitationem officia. Magnam aut autem excepturi cum. Deserunt rerum consequatur dolore voluptatem totam optio dolor ex. Dolore enim qui fugit.', '1998-06-12 12:37:14', '2016-09-24 13:18:54');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('22', '22', '22', 'Quas qui dolores autem nihil eos itaque aliquam. Et quidem quia nostrum. Praesentium omnis velit voluptatibus vitae est et nostrum est.', '2000-05-28 18:59:47', '1986-12-18 22:14:54');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('23', '23', '23', 'Sed et veritatis aspernatur. Reprehenderit consectetur illum doloremque nobis quia qui. Officia sit laboriosam similique et.', '1971-12-01 01:26:34', '2017-01-20 07:44:47');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('24', '24', '24', 'Non excepturi provident ab. Iure exercitationem magni enim illum ut autem.', '2018-06-24 21:35:57', '1979-09-10 12:23:06');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('25', '25', '25', 'Assumenda numquam architecto in sed aut autem a non. Delectus fugiat molestiae praesentium cupiditate.', '2010-11-07 14:47:53', '2009-04-09 15:56:21');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('26', '26', '26', 'Qui fugit est hic et quo. Sit labore deleniti repellendus eaque ipsum illum. Qui voluptas aut dolore repudiandae necessitatibus sapiente a. Voluptatem vitae eum inventore repellat voluptatem quasi labore nihil. Animi maxime quam provident mollitia.', '1989-07-08 11:46:52', '1998-03-15 12:45:24');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('27', '27', '27', 'Esse sint nostrum sed omnis. Sapiente ut voluptas et nihil error sequi. Ducimus et tempore fugiat et rerum aperiam.', '1983-09-20 01:35:46', '1973-07-05 08:37:05');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('28', '28', '28', 'Repudiandae fugit error sed corporis. Modi ducimus similique ipsa assumenda. Id animi dolore dolor aut. Inventore eveniet culpa voluptatem quia est ad vero quis.', '1983-10-25 02:15:29', '2014-09-14 09:51:10');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('29', '29', '29', 'Earum voluptatem est libero facilis. Ut minus sed quod quam dolor. Corrupti provident voluptas dolorem dolorem explicabo.', '2000-08-06 04:20:53', '1983-05-19 21:18:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('30', '30', '30', 'Alias voluptate nobis facere a atque natus eos sed. Nostrum nemo molestiae quo corporis architecto dignissimos architecto. Harum consequatur veritatis enim ratione sunt. Omnis laudantium tempora animi tenetur voluptatem sapiente hic nam.', '2005-06-23 09:38:20', '1971-08-08 22:08:00');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('31', '31', '31', 'Non dolorum assumenda facere delectus. Inventore voluptatem incidunt accusantium. Sapiente consequatur in rerum. Aut debitis adipisci perferendis velit aperiam.', '1992-03-03 04:35:38', '2019-07-29 09:19:08');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('32', '32', '32', 'Enim in consequatur voluptatibus dolores dicta qui. Non quis eum incidunt non iusto. Dolorem et in fugit numquam. Sed inventore est cum impedit accusamus.', '2004-02-04 03:07:23', '1976-09-21 00:41:07');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('33', '33', '33', 'Saepe necessitatibus ut ab. Eum ut quos aut sint repudiandae sit culpa sed. Porro rerum debitis iste et mollitia mollitia.', '1994-12-03 17:09:00', '2001-07-18 05:56:20');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('34', '34', '34', 'Ab et est minus enim. Atque tempore magni eum doloremque. In dolores nobis dolorem placeat necessitatibus. Ducimus in possimus facilis cum a dolorum.', '1998-01-06 11:51:53', '1997-07-07 14:44:33');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('35', '35', '35', 'Repellendus magnam beatae delectus alias dolorem aut vero deleniti. Enim ea ad corporis voluptatem ut. Excepturi modi unde distinctio inventore voluptate quidem.', '1995-09-28 22:27:07', '2018-08-17 06:47:07');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('36', '36', '36', 'Iusto ut voluptas id deleniti sed aut. Aliquam molestiae voluptas et natus fugiat. Sequi corrupti corporis doloremque ipsam consequuntur.', '1970-09-16 04:28:29', '2004-06-03 10:42:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('37', '37', '37', 'Voluptates sint omnis consectetur enim iure dolor rem laborum. Quam et numquam quia sed repellat asperiores. Qui velit iure aut facere.', '1987-07-30 04:13:19', '1986-10-18 10:20:58');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('38', '38', '38', 'Amet velit non consequatur corporis commodi consequatur fugit. Accusamus tempora et praesentium numquam id. Eos recusandae enim et quis sed in voluptatem.', '2012-08-14 20:55:15', '2003-01-31 07:17:54');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('39', '39', '39', 'Voluptate et sint ut sapiente facilis id exercitationem. Reiciendis sint dignissimos voluptatem qui ipsa nam ratione. Architecto iste et sint eius. Veritatis soluta repellat aut commodi quo. Cupiditate quas porro est et sed et optio numquam.', '1971-08-25 17:27:21', '1974-01-06 13:41:52');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('40', '40', '40', 'Dolorem qui consequatur dicta porro ut. Quae tempore sed earum reprehenderit est. Quaerat nisi veritatis quas. Corporis eaque doloribus eos quod.', '1981-02-04 09:54:58', '1971-02-25 18:25:02');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('41', '41', '41', 'Reiciendis ut occaecati consequatur. Et deleniti eos ab optio nam est.', '1988-08-26 21:43:16', '1975-12-07 21:57:55');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('42', '42', '42', 'Ex dignissimos sit qui suscipit. Delectus quo illum inventore et sapiente aut. Ducimus qui quibusdam aperiam fugiat delectus dolores mollitia. Ex facere non nemo nisi.', '2016-04-08 08:52:18', '2011-09-26 10:50:51');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('43', '43', '43', 'Est consequatur qui qui expedita. Laboriosam vel voluptas architecto voluptates provident optio. Asperiores rerum et corrupti aut. Dolore non aut aut ut sequi dicta.', '1970-02-11 13:16:33', '1970-07-01 19:50:28');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('44', '44', '44', 'Qui voluptatibus voluptatem cupiditate dolores. Qui soluta voluptas iure neque maxime nobis sapiente non. Similique facilis voluptatem aut eum ea sunt qui. Sit architecto molestiae et recusandae.', '1992-07-02 16:29:27', '2001-06-11 22:53:56');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('45', '45', '45', 'Sequi voluptatibus qui odio perferendis quia. Debitis autem vero error similique eum molestiae sint. Commodi molestias molestias blanditiis quia aut consequatur ut.', '1993-12-07 20:37:58', '2005-06-24 07:30:03');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('46', '46', '46', 'Et omnis officiis sequi quia assumenda. Dolorum ex et aspernatur id modi.', '1992-05-01 12:39:19', '1996-06-06 18:03:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('47', '47', '47', 'Libero sequi quia culpa ex sit et laudantium. Veritatis perspiciatis autem modi accusamus occaecati. Quia optio alias non voluptatem accusamus numquam culpa magnam.', '2012-07-04 20:58:05', '2015-12-29 04:27:41');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('48', '48', '48', 'Qui commodi dicta voluptatem recusandae necessitatibus molestiae voluptatem. Libero dolore omnis ut exercitationem quae iste. Impedit modi quod odit labore aut repudiandae qui consequatur.', '1974-11-25 08:36:53', '1996-10-07 06:03:11');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('49', '49', '49', 'Consequatur ut suscipit et laudantium illo inventore et molestiae. Aspernatur temporibus dolor error illum ducimus dignissimos omnis. Voluptatem ipsa ad porro blanditiis labore voluptate. Enim incidunt enim quisquam qui accusantium.', '2012-08-23 06:37:59', '1978-08-19 02:17:33');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('50', '50', '50', 'Et neque velit fuga rerum aut dolore. Et sunt accusamus esse et consequatur sapiente. Perspiciatis impedit non blanditiis sed dolore rerum voluptatem.', '1984-08-17 02:57:16', '1984-10-22 03:23:07');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('51', '51', '51', 'Et veniam neque distinctio fugiat eum libero nihil inventore. Perferendis ad repudiandae eos sit consequatur reprehenderit quia.', '2016-03-16 15:11:27', '2001-04-13 00:31:11');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('52', '52', '52', 'Fugit eos repudiandae assumenda asperiores non et. Occaecati laboriosam rerum velit corrupti ipsam. Quos maxime incidunt eum et incidunt atque doloremque.', '2014-01-02 06:08:16', '2009-07-31 15:59:15');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('53', '53', '53', 'Illo voluptatum consequatur suscipit incidunt est. In quaerat doloremque cupiditate omnis. Corporis consequatur et alias sapiente qui corrupti.', '1977-10-08 05:13:58', '1983-01-05 07:39:25');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('54', '54', '54', 'Non maiores sapiente et exercitationem. Autem exercitationem ut eum enim et fugiat. Labore repellendus laborum iusto voluptatem quibusdam qui blanditiis. Quaerat nihil nesciunt aut blanditiis harum quis ea.', '2005-05-19 23:00:26', '1972-10-27 01:39:18');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('55', '55', '55', 'Illo ipsam non fuga possimus iusto. Nisi repellendus delectus accusantium nulla. Iste ea beatae quis est veritatis laboriosam perferendis voluptatem. Dolorem itaque eligendi alias eum aut blanditiis vitae. Quo accusamus nostrum pariatur harum eveniet dolor beatae debitis.', '2011-04-09 02:03:47', '1999-03-19 21:44:27');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('56', '56', '56', 'Minus beatae aut et laudantium beatae inventore. Nisi animi occaecati dolorum qui velit libero ab. Sit itaque facilis quisquam ut. Veritatis enim aut sint.', '1991-02-11 11:33:14', '1989-04-17 21:26:18');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('57', '57', '57', 'Commodi ea et omnis alias blanditiis qui libero ut. Ut aut maxime aliquam adipisci architecto sed assumenda nobis. Non iusto quidem et consequatur asperiores dolore dolorem.', '1972-08-06 19:15:10', '1990-12-14 10:15:17');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('58', '58', '58', 'Harum tenetur provident sit. Tempora quae cumque eius ut accusamus voluptatem mollitia. Sunt non sed saepe necessitatibus non.', '1988-10-19 03:23:03', '1972-03-30 08:47:24');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('59', '59', '59', 'Sit expedita ut illo totam dolores unde. Fuga temporibus unde assumenda magni. Cum dolorem officiis ut beatae aut exercitationem quaerat. Asperiores officiis excepturi assumenda sequi voluptas.', '1992-09-22 05:47:42', '2013-09-28 12:37:13');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('60', '60', '60', 'Et et error deserunt omnis. Molestiae provident quibusdam saepe beatae. Perferendis quibusdam eum non sunt nesciunt qui possimus omnis.', '2003-08-09 00:31:18', '1979-06-02 01:56:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('61', '61', '61', 'Voluptatem et aspernatur est dolor sit. Facilis aspernatur ut est velit repellat corrupti. Cupiditate porro deserunt autem porro saepe officiis.', '1986-10-13 18:18:18', '1993-11-29 05:40:47');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('62', '62', '62', 'Consequatur sed blanditiis laborum sequi autem maxime. Accusamus labore enim facere tempora maiores. Sed officiis ex omnis nihil et.', '1986-07-15 17:25:59', '1978-07-02 01:34:57');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('63', '63', '63', 'Quibusdam voluptas ad tenetur ut. Reiciendis quas tempora enim et. Velit tempora quasi aspernatur et officia suscipit nam eos.', '1990-10-12 12:49:40', '1983-10-16 05:37:25');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('64', '64', '64', 'Cum quibusdam consectetur optio iure omnis eum. Accusamus corrupti est ut alias quae. Dolor quia maiores consequatur.', '2006-03-27 06:48:24', '2002-05-04 19:53:29');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('65', '65', '65', 'Earum magni soluta ullam consequatur tempora tempore. Quis sunt velit consequatur saepe laborum aut. Magnam iste ratione veritatis aut fugiat molestiae rerum sed.', '2010-06-10 07:57:18', '1993-12-08 12:53:43');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('66', '66', '66', 'Magni beatae nihil amet qui eligendi quia. Praesentium a consequatur inventore sint similique sequi. Hic unde magni officiis incidunt voluptatem. Nobis sapiente et dolor eius.', '2017-06-13 08:45:24', '1991-09-30 07:18:12');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('67', '67', '67', 'Veniam quia enim id soluta illo eveniet. Ut non natus debitis dolor pariatur sunt quibusdam rerum. Libero consequuntur eaque a tenetur magni.', '1990-11-17 14:46:35', '1982-06-12 14:53:24');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('68', '68', '68', 'Ea aut enim tempore qui. Facere quo dolorem in culpa. Exercitationem ut eum iure id enim. Repellat quos aliquam voluptatem vel ipsa atque. Atque tenetur tenetur optio voluptates et hic.', '1975-02-23 08:26:00', '2018-02-28 01:09:43');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('69', '69', '69', 'Sunt quia unde ut quia rerum vel. Numquam voluptatem aspernatur quidem rerum voluptatem. Possimus aliquid placeat illum vel. Quos ut repellat ab et.', '1976-04-02 18:39:20', '1973-06-20 12:32:00');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('70', '70', '70', 'Ducimus et cupiditate quasi sed provident. Aut facere et fuga qui eum modi est sit. Sit quae facilis consectetur tempore dolores corporis. Laudantium labore quidem omnis qui odio sequi sunt accusantium.', '2009-07-24 04:55:58', '2016-10-15 23:13:38');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('71', '71', '71', 'Quasi quidem et tempore sint. Excepturi illum pariatur quae suscipit minima incidunt. Voluptatem quidem aliquid repellat explicabo quo dolore. Beatae cupiditate quibusdam in illo inventore unde rerum consequatur.', '1989-05-22 02:50:43', '2003-04-14 06:10:08');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('72', '72', '72', 'Repudiandae soluta nihil possimus veritatis magni omnis. Repudiandae error est voluptatum minus. Accusamus eius totam vel facere.', '2015-05-03 09:51:28', '2017-10-21 16:43:30');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('73', '73', '73', 'Qui laborum excepturi rerum consequatur voluptate rerum pariatur. Vel officiis non pariatur qui.', '1973-05-11 09:23:14', '2005-07-23 18:51:43');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('74', '74', '74', 'Perspiciatis aut dicta deserunt est eos fugiat ut. Consequuntur veritatis et doloremque autem ut cupiditate. Soluta quam velit consequatur velit quia.', '1985-01-03 11:13:31', '1999-10-02 01:23:38');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('75', '75', '75', 'Tenetur qui quo reiciendis voluptas nihil. Pariatur in autem non suscipit omnis quia esse. Molestias culpa esse sed. Consequatur non deleniti id. Iste nemo provident voluptates illo dicta nam a.', '1980-07-13 17:29:16', '1990-01-07 13:06:00');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('76', '76', '76', 'Illum vitae est aut. Maiores iusto dignissimos fuga iure facere. Et animi soluta sunt libero perferendis consequuntur porro.', '2019-10-21 06:55:24', '1993-06-03 18:35:03');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('77', '77', '77', 'Voluptates quo eius quis velit ut. Inventore velit error corporis quia beatae commodi. Quis distinctio odio modi deleniti et molestias in. Qui quod qui repudiandae omnis quia.', '1972-09-09 19:14:21', '1971-11-24 09:24:19');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('78', '78', '78', 'Ut qui quia neque enim dolores facilis. Perferendis ullam occaecati error iure expedita. Possimus et quia soluta iste rerum rerum eos. Dignissimos eos molestiae et et.', '2008-01-07 07:29:56', '1990-06-22 01:26:15');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('79', '79', '79', 'Voluptatem aperiam ad cum deserunt dolorem quaerat esse. Magni aut alias unde ad inventore. Dolor distinctio similique ad ut provident.', '2004-05-13 22:29:46', '2004-12-03 13:56:39');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('80', '80', '80', 'Consequuntur ut quos aliquam perferendis molestiae repellat ut omnis. Praesentium exercitationem repellat minus et quia blanditiis perspiciatis. Nostrum tempora accusamus reiciendis explicabo quidem eveniet dolor. Quasi repellat ut dolore magni neque. Inventore iste fugiat id temporibus non blanditiis debitis aut.', '2018-02-26 20:06:02', '2002-11-09 08:07:44');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('81', '81', '81', 'Aperiam aperiam labore eos omnis facilis quis quibusdam facere. Quisquam quo consequatur accusantium qui expedita maxime ullam. Omnis earum et laborum corrupti qui odit consequatur.', '2013-08-11 02:13:35', '2010-10-04 06:55:15');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('82', '82', '82', 'Nesciunt sed est minima sunt. Fugit vel adipisci facilis molestiae qui. Est et quis nulla voluptas est. Et vero quia amet veritatis delectus repellendus quae. Qui et occaecati est pariatur omnis.', '1986-02-02 12:06:21', '1982-08-18 19:06:29');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('83', '83', '83', 'Beatae perferendis pariatur et vero omnis quas quis. Voluptas laborum enim incidunt pariatur omnis ipsum. Ut magni nihil consequatur at ut quia exercitationem.', '2019-06-22 01:06:36', '1986-01-14 08:21:21');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('84', '84', '84', 'Nobis similique officia harum. Ab totam possimus atque possimus architecto laudantium officiis. Blanditiis quia fugiat earum similique est. Aliquam maiores impedit magnam incidunt incidunt magni unde.', '2013-09-28 07:02:20', '2002-05-11 13:27:05');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('85', '85', '85', 'Voluptatem ut sed voluptas dignissimos. Non fuga quo corporis et in. Molestiae veniam id eaque et quod fugiat perferendis. Ut eos ipsa alias occaecati officia. Eaque in consectetur rem magnam beatae eos excepturi et.', '1985-06-21 11:17:42', '2008-08-21 19:56:52');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('86', '86', '86', 'Ad est rerum inventore repellendus perspiciatis et. Adipisci nulla consequatur magnam est corporis eaque. Dignissimos molestiae blanditiis omnis id omnis sunt perferendis.', '2004-11-18 08:01:21', '1987-12-04 23:31:17');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('87', '87', '87', 'Non voluptatum molestiae aliquid qui qui. Non temporibus eius consequatur sunt maiores ut. Ab ut fugit ex qui.', '1976-12-10 21:45:57', '1985-02-21 15:25:20');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('88', '88', '88', 'Et delectus sit vero officia qui. Quidem accusamus id et quo laborum eveniet pariatur. Facilis beatae reiciendis incidunt similique. Rerum quia ducimus ut nihil nisi ducimus eligendi.', '1981-04-20 07:22:22', '1976-12-21 04:21:36');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('89', '89', '89', 'Quod recusandae tempore consectetur. Sit ipsam maxime eos nobis perspiciatis vero mollitia. Magnam modi a quia eaque qui doloribus. Sunt atque quas voluptas aut eos quidem.', '1983-07-14 05:01:01', '1980-03-17 18:28:27');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('90', '90', '90', 'Deleniti ipsam debitis quaerat. Quasi sequi quaerat quod ab provident ipsa. Harum totam sed sit accusamus expedita a maiores.', '2011-12-07 05:33:32', '1986-08-28 11:03:16');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('91', '91', '91', 'Et sunt animi sit fuga odio praesentium fugiat. Laudantium atque eveniet earum sit consectetur porro. Dolorem quod veritatis incidunt eveniet.', '1975-08-23 13:43:13', '1977-11-10 18:09:43');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('92', '92', '92', 'Est distinctio corporis perspiciatis dolorem. Voluptatum qui voluptas necessitatibus dolore ex provident nam. Consectetur unde eaque consequuntur incidunt eaque doloremque.', '1970-04-26 20:23:57', '1991-12-04 06:00:10');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('93', '93', '93', 'Fugiat et ut laudantium nihil consequuntur. Praesentium reiciendis at esse eum illo perferendis est.', '2015-05-02 13:38:16', '2006-03-01 01:18:30');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('94', '94', '94', 'Sit non aliquid veritatis voluptatibus impedit ut voluptate earum. Id rerum inventore cumque et necessitatibus est officia. Veniam itaque quae esse iusto. Id aut et enim officia.', '2002-04-24 04:03:01', '2018-10-15 06:48:14');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('95', '95', '95', 'Reprehenderit nisi debitis nulla quia possimus consequatur praesentium. Libero suscipit et rerum provident corporis tempora esse. Aspernatur expedita incidunt exercitationem non eum quis. Ipsum maiores ex natus eum odio blanditiis eos sunt.', '2006-10-23 17:18:08', '1978-01-29 11:02:58');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('96', '96', '96', 'Aut voluptates ducimus enim. Consequatur asperiores qui et. Facere velit illo distinctio accusamus dolorum tempora. Neque perspiciatis quia est nobis maiores sequi facilis sunt.', '2020-09-12 21:12:26', '1988-03-30 01:57:38');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('97', '97', '97', 'In corrupti repellendus et nemo et blanditiis minus. Illo id reiciendis doloremque aut qui. Ipsum ex ut ut cumque voluptatem.', '1984-07-06 17:37:43', '2020-07-10 16:08:24');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('98', '98', '98', 'Est sint nisi impedit sed omnis praesentium qui earum. Quis necessitatibus velit et aut quaerat ea officiis. Qui incidunt laboriosam sunt officiis facilis dolores numquam. Asperiores et fugiat est cupiditate sed.', '1999-12-05 21:07:29', '1970-07-14 00:04:41');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('99', '99', '99', 'Illo id assumenda dignissimos quis mollitia doloremque odit. Quibusdam laudantium officiis blanditiis reprehenderit delectus aut. Sed nobis dolor qui voluptate necessitatibus.', '1978-11-01 14:00:34', '1998-10-30 16:42:38');
INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comments`, `created_at`, `updated_at`) VALUES ('100', '100', '100', 'Quae inventore ratione exercitationem rerum eum amet est neque. Inventore nemo sit dolore velit maxime. Explicabo pariatur ad quia exercitationem soluta.', '2008-11-06 06:30:34', '1988-10-20 13:43:50');

INSERT INTO `communities` (`id`, `name`) VALUES ('5', 'ab');
INSERT INTO `communities` (`id`, `name`) VALUES ('15', 'accusantium');
INSERT INTO `communities` (`id`, `name`) VALUES ('28', 'amet');
INSERT INTO `communities` (`id`, `name`) VALUES ('12', 'aperiam');
INSERT INTO `communities` (`id`, `name`) VALUES ('7', 'aut');
INSERT INTO `communities` (`id`, `name`) VALUES ('16', 'commodi');
INSERT INTO `communities` (`id`, `name`) VALUES ('25', 'corporis');
INSERT INTO `communities` (`id`, `name`) VALUES ('27', 'debitis');
INSERT INTO `communities` (`id`, `name`) VALUES ('3', 'earum');
INSERT INTO `communities` (`id`, `name`) VALUES ('9', 'est');
INSERT INTO `communities` (`id`, `name`) VALUES ('14', 'et');
INSERT INTO `communities` (`id`, `name`) VALUES ('22', 'et');
INSERT INTO `communities` (`id`, `name`) VALUES ('21', 'eum');
INSERT INTO `communities` (`id`, `name`) VALUES ('1', 'explicabo');
INSERT INTO `communities` (`id`, `name`) VALUES ('23', 'facilis');
INSERT INTO `communities` (`id`, `name`) VALUES ('20', 'fugiat');
INSERT INTO `communities` (`id`, `name`) VALUES ('24', 'laboriosam');
INSERT INTO `communities` (`id`, `name`) VALUES ('4', 'natus');
INSERT INTO `communities` (`id`, `name`) VALUES ('8', 'non');
INSERT INTO `communities` (`id`, `name`) VALUES ('30', 'odit');
INSERT INTO `communities` (`id`, `name`) VALUES ('11', 'omnis');
INSERT INTO `communities` (`id`, `name`) VALUES ('10', 'qui');
INSERT INTO `communities` (`id`, `name`) VALUES ('29', 'qui');
INSERT INTO `communities` (`id`, `name`) VALUES ('6', 'quo');
INSERT INTO `communities` (`id`, `name`) VALUES ('26', 'reprehenderit');
INSERT INTO `communities` (`id`, `name`) VALUES ('17', 'rerum');
INSERT INTO `communities` (`id`, `name`) VALUES ('19', 'saepe');
INSERT INTO `communities` (`id`, `name`) VALUES ('13', 'sunt');
INSERT INTO `communities` (`id`, `name`) VALUES ('2', 'voluptas');
INSERT INTO `communities` (`id`, `name`) VALUES ('18', 'voluptatem');

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '93', 'approved', '1995-11-21 06:53:42', '2013-11-29 04:01:56');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '61', 'unfriended', '1978-12-14 23:24:00', '2000-10-28 06:45:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '69', 'declinde', '1975-06-02 12:20:02', '2020-01-07 07:26:58');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '75', 'approved', '2017-09-24 08:26:42', '1974-03-26 16:20:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '58', 'declinde', '1980-12-16 04:38:27', '1990-07-29 23:58:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '16', 'approved', '1970-12-22 21:42:36', '1978-11-12 05:03:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '87', 'declinde', '2008-05-04 10:52:21', '1983-09-28 06:33:57');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('13', '30', 'approved', '1980-01-22 21:11:37', '2006-06-12 12:51:34');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('14', '18', 'approved', '1973-08-26 17:58:41', '1970-05-29 06:30:44');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('14', '41', 'declinde', '1994-08-11 05:32:27', '1994-05-01 22:36:01');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('15', '44', 'declinde', '2006-01-12 11:08:49', '2004-02-16 13:24:40');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('15', '78', 'requested', '2011-05-12 03:55:58', '2010-07-21 13:16:35');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('16', '4', 'unfriended', '1986-03-27 13:39:13', '1988-06-23 23:24:46');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('16', '20', 'declinde', '1980-08-20 18:04:21', '1975-02-25 10:07:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('17', '9', 'approved', '1987-07-16 11:03:11', '1987-02-12 17:23:35');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('17', '84', 'unfriended', '1998-06-16 18:18:32', '2013-04-14 12:49:42');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('20', '71', 'declinde', '2002-03-09 23:32:28', '1974-03-12 05:30:14');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('22', '29', 'unfriended', '1986-03-09 02:15:45', '1984-04-17 03:38:16');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('22', '70', 'declinde', '2002-11-04 18:59:28', '2015-10-31 15:13:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('22', '85', 'requested', '1983-01-10 18:04:21', '2012-11-25 02:42:19');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('25', '15', 'requested', '2001-06-19 09:54:35', '1986-10-13 22:54:56');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('25', '38', 'approved', '1976-05-09 21:04:29', '2001-05-29 00:58:59');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('25', '99', 'declinde', '2015-05-12 09:10:24', '2002-08-16 08:37:00');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('25', '100', 'declinde', '1970-09-23 11:32:50', '2011-02-23 19:51:25');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('26', '73', 'declinde', '1976-03-01 09:37:21', '2008-06-22 10:24:19');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('30', '16', 'declinde', '1997-05-10 08:05:25', '1972-01-30 06:45:28');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('30', '25', 'requested', '2015-08-02 07:11:41', '2004-03-07 06:59:41');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('31', '57', 'requested', '1971-07-10 16:25:28', '1972-04-06 09:46:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('31', '80', 'unfriended', '2009-02-20 07:49:03', '1973-09-25 17:58:42');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('31', '87', 'requested', '1991-12-25 10:49:26', '2020-03-20 15:30:23');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('32', '38', 'approved', '1990-07-09 16:02:51', '2006-08-14 17:50:30');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('33', '41', 'declinde', '1975-06-10 02:45:45', '1981-07-28 18:10:57');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('34', '8', 'approved', '2017-09-16 19:56:34', '2009-09-20 16:49:13');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('34', '46', 'requested', '1994-10-01 22:48:18', '1976-03-22 01:31:57');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('36', '47', 'requested', '1990-06-04 05:25:45', '2003-04-06 11:14:22');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('37', '48', 'approved', '2010-04-10 07:48:00', '1977-12-16 19:50:28');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('38', '54', 'requested', '2010-04-05 00:29:44', '1971-03-15 19:47:33');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('38', '76', 'requested', '2018-02-17 14:24:44', '1983-03-12 11:32:21');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('39', '92', 'unfriended', '1992-05-28 08:31:21', '1984-07-20 20:22:33');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('40', '11', 'declinde', '1973-12-29 23:05:41', '2016-10-15 13:06:06');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('40', '99', 'declinde', '1971-05-11 10:34:26', '1998-10-11 09:30:37');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('41', '18', 'declinde', '2005-09-18 16:12:33', '1974-12-19 17:20:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('41', '29', 'approved', '2009-06-16 23:29:08', '1999-05-18 21:11:30');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('41', '40', 'declinde', '1972-05-17 17:10:08', '1979-06-19 17:06:54');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('42', '15', 'unfriended', '2006-03-14 02:15:37', '1983-07-15 12:17:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('42', '63', 'unfriended', '2015-03-12 01:00:13', '1995-01-27 07:37:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('42', '99', 'requested', '2010-03-29 11:14:18', '1988-08-09 05:42:25');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('43', '16', 'approved', '2017-07-05 14:15:55', '1975-08-30 05:35:09');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('43', '43', 'unfriended', '2010-03-01 01:17:18', '2019-03-17 16:33:02');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('44', '58', 'declinde', '1985-07-14 01:32:56', '1977-01-14 13:21:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('45', '25', 'approved', '2001-04-22 23:38:19', '2012-07-30 08:41:33');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('45', '63', 'unfriended', '2008-06-30 01:35:18', '2013-10-31 20:48:06');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('45', '71', 'unfriended', '1997-09-01 12:13:20', '2013-07-13 15:41:16');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('45', '83', 'requested', '1976-04-03 19:58:46', '1989-11-20 15:43:53');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('46', '48', 'declinde', '2014-05-21 07:52:10', '2014-07-13 12:28:51');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('46', '59', 'unfriended', '2006-12-26 06:34:18', '1973-07-15 13:36:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('46', '62', 'declinde', '1970-04-20 18:13:10', '2020-02-19 14:48:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('46', '71', 'approved', '2012-05-13 09:50:03', '2001-04-21 14:08:55');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('46', '89', 'approved', '1976-04-07 08:10:37', '1996-02-24 02:14:56');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('50', '84', 'unfriended', '1978-04-15 18:56:32', '2016-07-18 13:51:23');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('51', '66', 'approved', '2012-05-11 23:15:48', '1985-04-29 17:34:43');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('51', '76', 'unfriended', '2017-05-21 11:02:28', '1985-01-29 16:17:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('53', '46', 'declinde', '1976-11-05 06:53:07', '2011-05-14 07:47:55');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('54', '18', 'requested', '1979-01-14 10:30:13', '2007-12-27 16:18:33');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('54', '55', 'unfriended', '1997-04-20 20:56:52', '1976-07-15 13:41:42');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('57', '27', 'approved', '2014-02-04 15:34:49', '1981-02-17 09:39:55');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('58', '58', 'declinde', '2012-04-24 23:50:35', '1984-06-15 15:20:43');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('60', '44', 'unfriended', '2004-05-09 16:50:58', '1979-01-05 10:28:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('61', '48', 'approved', '1988-11-15 16:29:30', '1995-10-13 21:58:45');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('61', '82', 'unfriended', '2000-06-22 06:33:34', '1996-08-25 17:37:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('62', '4', 'unfriended', '1972-07-16 16:48:08', '2019-04-05 23:25:21');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('64', '1', 'declinde', '2019-08-27 18:18:45', '1987-03-15 20:17:31');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('67', '57', 'declinde', '2014-06-09 02:41:08', '2006-01-16 23:29:12');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('67', '77', 'approved', '2016-03-25 23:28:26', '2005-10-14 05:38:13');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('70', '21', 'requested', '2008-09-06 09:55:42', '1991-10-07 04:48:36');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('72', '88', 'unfriended', '1978-09-18 04:48:06', '1992-07-07 10:16:57');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('73', '27', 'unfriended', '2014-10-05 21:00:14', '1981-09-07 01:19:45');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('73', '93', 'unfriended', '2019-12-03 16:37:09', '1976-04-15 12:29:49');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('73', '100', 'unfriended', '1992-03-12 02:17:58', '2018-10-13 04:02:48');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('80', '89', 'requested', '2003-10-07 09:02:08', '1991-10-31 20:06:01');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('81', '49', 'approved', '1981-03-22 06:07:32', '1977-03-10 14:30:34');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('85', '16', 'approved', '1977-09-30 20:59:19', '2018-09-04 22:52:26');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('85', '65', 'unfriended', '2005-03-31 11:00:30', '1982-08-08 01:27:05');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('85', '99', 'approved', '1984-06-26 15:12:42', '2008-05-19 03:01:23');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('88', '33', 'approved', '2005-09-25 09:21:44', '2000-06-04 18:47:38');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('88', '52', 'declinde', '1983-12-09 03:27:52', '1989-09-07 15:48:47');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('88', '66', 'approved', '2020-10-25 13:48:29', '1987-12-26 01:08:58');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('88', '71', 'approved', '2018-12-05 20:27:55', '1970-05-11 23:47:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('92', '2', 'unfriended', '2018-03-27 22:59:42', '1975-10-27 22:01:29');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('92', '87', 'approved', '2013-10-10 16:47:13', '1974-11-15 05:23:25');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('93', '6', 'approved', '1996-07-21 12:09:00', '1972-06-12 05:18:26');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('93', '75', 'requested', '2012-03-25 07:18:37', '2020-07-18 21:39:52');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('94', '32', 'approved', '1975-03-10 14:41:56', '1991-08-28 11:03:52');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('95', '17', 'declinde', '1995-10-15 16:41:43', '1973-07-06 06:12:53');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('95', '77', 'approved', '2012-09-16 05:44:47', '2011-09-20 07:34:09');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('96', '24', 'unfriended', '2008-08-14 13:50:07', '1971-05-13 23:37:21');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('96', '71', 'declinde', '1990-01-24 08:22:07', '1973-09-29 01:31:13');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('100', '17', 'requested', '2006-08-13 13:28:51', '1977-01-11 19:44:56');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('100', '25', 'declinde', '1999-08-06 02:38:40', '2001-02-04 04:36:33');

INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('52', '77', '100', '64', '58', '43');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('64', '61', '93', '18', '28', '92');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('1', '77', '87', '84', '17', '70');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('77', '32', '48', '60', '10', '15');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('23', '17', '15', '37', '89', '49');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('29', '40', '26', '28', '4', '84');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('71', '67', '44', '64', '85', '72');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('55', '85', '48', '41', '69', '65');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('10', '45', '96', '58', '5', '5');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('73', '28', '21', '88', '65', '10');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('36', '93', '49', '61', '20', '52');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('44', '91', '19', '88', '54', '4');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('59', '9', '89', '7', '49', '57');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('71', '59', '2', '66', '17', '7');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('70', '89', '34', '91', '76', '98');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('100', '11', '90', '49', '72', '10');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('1', '16', '1', '19', '3', '54');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('23', '62', '62', '11', '68', '11');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('67', '38', '70', '68', '4', '86');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('75', '74', '74', '8', '64', '49');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('6', '64', '60', '96', '12', '31');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('5', '12', '46', '5', '31', '49');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('59', '53', '11', '21', '63', '78');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('31', '30', '16', '100', '97', '20');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('85', '71', '93', '58', '79', '56');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('7', '84', '19', '66', '79', '30');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('96', '84', '42', '42', '89', '72');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('91', '48', '25', '1', '68', '87');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('79', '98', '17', '94', '98', '14');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('14', '83', '84', '6', '41', '63');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('61', '47', '47', '80', '12', '25');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('10', '8', '9', '51', '50', '98');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('23', '40', '45', '48', '41', '12');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('35', '19', '10', '51', '13', '8');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('64', '26', '90', '48', '31', '30');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('10', '92', '76', '56', '71', '88');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('81', '81', '96', '90', '32', '46');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('87', '54', '86', '31', '2', '26');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('43', '36', '45', '53', '86', '57');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('60', '49', '83', '49', '96', '14');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('79', '6', '5', '54', '62', '76');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('42', '43', '56', '38', '32', '88');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('84', '19', '42', '69', '50', '43');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('95', '92', '78', '40', '45', '63');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('97', '4', '12', '79', '52', '8');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('92', '30', '14', '97', '84', '75');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('72', '26', '18', '28', '64', '50');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('15', '47', '68', '56', '15', '18');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('98', '10', '10', '76', '49', '54');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('39', '45', '57', '50', '24', '9');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('58', '15', '38', '71', '12', '22');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('46', '83', '48', '63', '11', '11');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('12', '26', '57', '80', '82', '72');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('97', '80', '81', '6', '55', '30');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('59', '93', '74', '16', '43', '97');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('24', '100', '12', '62', '71', '23');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('83', '16', '6', '31', '79', '17');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('41', '91', '42', '97', '70', '24');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('69', '67', '3', '50', '73', '57');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('79', '32', '50', '53', '47', '92');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('50', '70', '92', '62', '31', '62');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('85', '14', '78', '90', '44', '56');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('7', '84', '46', '49', '81', '16');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('72', '49', '82', '75', '99', '54');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('31', '77', '85', '81', '30', '31');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('73', '79', '1', '65', '41', '31');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('26', '25', '44', '4', '15', '88');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('59', '21', '71', '5', '70', '52');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('20', '41', '100', '1', '15', '98');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('55', '46', '75', '40', '27', '4');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('71', '99', '83', '71', '63', '23');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('1', '89', '47', '45', '92', '62');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('32', '51', '82', '3', '55', '52');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('54', '74', '93', '54', '75', '8');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('52', '29', '53', '26', '68', '80');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('30', '39', '78', '13', '9', '41');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('36', '10', '29', '83', '54', '21');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('44', '86', '71', '26', '88', '26');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('77', '42', '99', '69', '95', '73');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('76', '47', '2', '29', '73', '70');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('8', '2', '8', '86', '15', '17');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('26', '50', '26', '55', '32', '80');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('76', '76', '65', '46', '1', '53');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('72', '77', '95', '70', '46', '89');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('43', '22', '35', '45', '50', '7');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('14', '58', '9', '22', '43', '24');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('38', '69', '73', '63', '24', '5');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('42', '99', '80', '7', '45', '81');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('60', '16', '57', '54', '86', '3');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('43', '29', '24', '78', '73', '74');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('85', '86', '31', '94', '7', '74');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('17', '44', '43', '90', '7', '67');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('94', '49', '65', '74', '55', '10');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('54', '15', '26', '11', '68', '11');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('14', '11', '40', '37', '88', '12');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('11', '72', '98', '42', '65', '5');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('16', '82', '49', '58', '71', '55');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('24', '65', '3', '89', '38', '58');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('99', '92', '72', '24', '3', '40');
INSERT INTO `likes` (`who_like_id`, `whom_like_id`, `message_id`, `post_id`, `comment_id`, `photo_id`) VALUES ('35', '16', '50', '74', '53', '37');

INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('1', '12', '81', 'Nemo qui fugiat sint officiis quis voluptas nostrum quod. Est sapiente qui qui eius libero aspernatur ut. Et necessitatibus et voluptates. Aut et vero voluptatum voluptatum.', 1, '1989-08-24 08:37:01');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('2', '79', '71', 'Ex laboriosam sapiente eos dolores debitis ut. Nihil cupiditate nesciunt explicabo non. Dignissimos nobis eaque voluptatum quia eum temporibus molestiae.', 1, '2019-07-17 10:30:09');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('3', '86', '31', 'Ea et ratione officiis. Earum eaque ipsam sit. Molestiae ut aliquid rerum a et voluptas in. Optio non natus est reiciendis magnam omnis ea.', 0, '1985-05-24 21:27:39');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('4', '47', '86', 'Impedit quis et laborum rem. Repellendus et maxime et repellat saepe. Earum voluptatem ad velit veniam quas rerum.', 0, '1981-09-03 16:52:53');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('5', '32', '38', 'Cum magni quia ipsum omnis id corrupti laborum. Voluptas natus minus et voluptas.', 0, '2007-06-22 03:46:25');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('6', '61', '25', 'Sed vero cupiditate accusantium quae consectetur quis quis. Ut natus nam dolore rerum ullam est voluptas.', 0, '1975-10-06 02:08:10');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('7', '5', '47', 'Blanditiis sapiente atque sunt dolorum deleniti. Nisi id corporis alias ea voluptatum accusamus. Vel recusandae non nam perspiciatis esse velit eveniet.', 1, '1981-09-05 00:59:33');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('8', '40', '15', 'Occaecati magni consequatur inventore accusantium sint sunt optio reprehenderit. Culpa sit dolores rerum. Cum praesentium quisquam assumenda ea veniam. Quae quia dolores ipsum fugiat eius. Esse non aut ut nostrum beatae.', 0, '1984-08-22 18:02:07');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('9', '90', '23', 'Error et voluptates beatae. Et suscipit sed fuga sunt laboriosam. Explicabo ea reprehenderit illum distinctio maxime. Cupiditate quis saepe commodi rerum.', 0, '2015-08-20 14:48:50');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('10', '82', '35', 'Consequuntur ea quis nam ullam quibusdam. Officia ipsum molestias rerum sint modi ut. Amet nemo repudiandae quaerat deleniti nobis suscipit.', 0, '1976-06-30 09:37:31');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('11', '8', '37', 'Veniam quisquam aut cupiditate quia ut. Magni officia enim et laudantium ut eaque in. Reprehenderit est quia explicabo iste quia.', 1, '1986-02-07 17:27:01');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('12', '88', '21', 'Numquam quasi ducimus sint facere sint commodi. Rerum quibusdam ea aut veritatis doloribus. Rerum dicta ipsam architecto non beatae quod quisquam.', 0, '2014-12-17 13:46:23');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('13', '72', '26', 'Veniam voluptas cumque qui magni neque ipsum. Velit et earum inventore error soluta impedit accusamus.', 1, '1989-08-24 19:25:31');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('14', '52', '34', 'Dolorem ut adipisci corporis aut doloribus sapiente qui. Ducimus qui ipsum ut dolores occaecati iusto. Asperiores architecto et id ipsa quae molestias.', 0, '2003-08-27 15:55:11');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('15', '55', '55', 'Dolores nihil delectus excepturi iusto sequi porro sit laboriosam. Officia et temporibus ad totam sint est. Eligendi illum sit quis aliquid. Sed possimus aut eum ea illum.', 1, '1990-09-25 06:58:37');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('16', '46', '67', 'Et at porro reiciendis et omnis. Nihil magni atque iusto ullam. Ut illo ut repellat doloremque et. Molestiae facere qui sunt exercitationem dolorem. Autem dolor repudiandae voluptatem est.', 0, '1973-04-03 12:20:22');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('17', '36', '24', 'Ad est et sit autem reprehenderit et magnam. Molestiae nihil reiciendis fugit aut quo velit. Ut fuga repellat porro ut voluptatem consequatur delectus. Consectetur et distinctio harum voluptatem iure tempore nostrum. At voluptas eum in quisquam eius.', 0, '2008-01-27 23:31:51');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('18', '38', '21', 'Animi ad consequuntur doloremque sapiente in officia dolorem sequi. Aspernatur minima nobis eligendi animi. Explicabo ad est totam facilis iusto et adipisci. Dicta quo debitis molestias nobis.', 1, '2009-03-23 07:51:43');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('19', '55', '84', 'Ea qui laudantium enim odit architecto. Id ut eveniet earum. Provident itaque quis quia vitae asperiores. Magni velit voluptate deleniti ea facere. Ut aut aut sunt distinctio.', 1, '1993-06-05 18:06:32');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('20', '7', '87', 'Est accusantium porro autem aliquid. Necessitatibus dolor eaque consequuntur et incidunt. Officia modi libero est expedita dignissimos.', 0, '2008-02-14 10:11:31');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('21', '22', '67', 'Consequatur voluptates praesentium id ipsa ut. Quod minima aspernatur aperiam ipsa. Et quia quibusdam aspernatur ea aut. Totam cumque repellat molestias. Rerum qui et est quo non.', 1, '1977-01-30 05:32:13');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('22', '12', '26', 'Non dolores corporis repellendus rem delectus nostrum. Dicta quaerat iusto dolores consequatur quia aspernatur. Fugiat aut ipsa excepturi eum nulla.', 1, '1972-08-17 15:48:00');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('23', '13', '51', 'Iste nisi dicta cum esse error voluptatem. Sint et omnis saepe accusamus praesentium veniam. Nulla non nihil non. Enim doloremque sit maxime quia tempora provident.', 1, '2013-05-01 00:58:54');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('24', '40', '2', 'Non est laborum dolorem quasi nam blanditiis deserunt. Et laborum nihil iste voluptatem. Delectus nihil earum voluptatum exercitationem expedita id.', 1, '1988-12-18 20:56:52');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('25', '74', '22', 'Animi placeat reprehenderit assumenda sit. Veniam repellat amet et nihil ullam quo. Deserunt molestiae sit voluptatem non. Nemo est a alias possimus voluptate explicabo.', 0, '1979-06-10 07:27:44');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('26', '37', '81', 'Molestias aliquid praesentium dicta nam rerum sint. Nobis est et quibusdam ut quia harum optio. Neque dolor est omnis id quasi dignissimos.', 1, '2003-05-10 22:53:19');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('27', '59', '24', 'Dolores in rerum voluptatem dolore et ut aut. Sunt qui omnis minus ut libero. Omnis ut possimus in saepe nam rerum sit id. Eveniet nobis vitae sapiente eveniet officia dolor.', 0, '1973-07-06 16:53:36');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('28', '1', '30', 'Dolore dolorem consequatur tempora provident temporibus laboriosam error quidem. Qui consectetur facere assumenda quis. Et corporis deleniti mollitia ipsum. Exercitationem similique perferendis cumque expedita quia.', 1, '2003-11-30 03:18:37');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('29', '50', '53', 'Enim ea voluptates ut qui distinctio. Aut voluptate et totam perferendis aut. Repudiandae earum quaerat et architecto dolore. Quia voluptatum voluptas vel.', 1, '1991-07-23 11:01:47');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('30', '64', '5', 'Consequatur eaque est laborum quis quae tenetur. Voluptate qui nobis quisquam hic unde. Sapiente et aspernatur enim id quo est est.', 0, '1994-03-31 14:36:35');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('31', '8', '10', 'Hic commodi iure inventore vitae nihil et. Id perferendis aliquid sunt est cupiditate. Est sint est quos et sit. Ea est qui ipsa officiis.', 1, '1986-04-16 18:29:19');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('32', '72', '43', 'Dolores vitae odio aut quas sed. In omnis voluptate laborum esse aperiam aspernatur explicabo odit. Ipsa facere omnis et voluptas et veniam totam. Asperiores consectetur inventore veniam deleniti velit velit.', 0, '1993-11-25 17:37:37');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('33', '33', '9', 'Ut deserunt repudiandae voluptatem et quis blanditiis qui magni. Reiciendis voluptatem ducimus consequatur voluptas magnam. Aut officia non dolor officiis delectus. Est et expedita nulla. Vitae expedita nobis assumenda pariatur omnis sunt molestiae.', 0, '1977-09-06 20:04:52');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('34', '64', '88', 'Aspernatur voluptas id est libero placeat. Maxime praesentium doloribus mollitia dolor minus rerum animi. Laudantium error quas ut dolorum consequatur est dolorum. Aliquid ullam incidunt enim laboriosam. Fugiat earum voluptatum optio qui quis ad ea.', 1, '1983-02-01 07:40:00');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('35', '92', '71', 'Ut aut et temporibus. Sint porro quia ea nisi officiis quo.', 1, '1976-11-01 17:10:47');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('36', '74', '13', 'Qui beatae vero ex. Veritatis velit voluptas vero odit quidem. Exercitationem aliquid harum dolor.', 1, '2005-06-03 22:41:09');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('37', '37', '85', 'Quis veritatis ut praesentium beatae ea incidunt. Molestiae qui dolorum rerum. Voluptatum aliquam itaque aut natus qui ut qui.', 1, '1990-03-10 08:43:19');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('38', '39', '50', 'Et earum doloremque labore nihil. Enim cum quibusdam enim aut tenetur repudiandae non placeat. Consequuntur aspernatur ipsa aut ipsum beatae eos culpa.', 1, '1978-03-06 20:35:04');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('39', '36', '79', 'Eum debitis ipsam debitis aspernatur. Nihil illo quia iste veniam qui et. Perspiciatis iure molestiae sint non excepturi.', 1, '2016-02-29 22:41:43');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('40', '51', '9', 'Est inventore et laborum est laboriosam consequuntur nostrum. Iure laudantium illo sint rerum.', 0, '1977-04-25 09:08:53');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('41', '100', '88', 'Laudantium reprehenderit officia suscipit rerum eligendi. Facilis voluptas itaque consequatur qui soluta molestiae.', 1, '1994-02-13 22:36:16');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('42', '89', '59', 'Quis qui provident sed esse veniam sit. Quo iusto blanditiis libero excepturi doloribus est illum excepturi. Aut excepturi consectetur ut. Voluptatem molestiae cupiditate autem dolorum ut illum rerum.', 1, '1983-03-20 00:45:02');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('43', '12', '89', 'Cum dolor nemo quis quas. Ipsa et quam rem. Omnis quia animi aut aliquid hic.', 1, '2006-01-23 18:38:39');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('44', '88', '62', 'Est temporibus quia et ut voluptatem. Veritatis vel maiores id.', 1, '1971-08-08 12:05:56');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('45', '42', '52', 'Ullam sed amet ullam totam et quia aut. Nobis magni omnis omnis et pariatur quasi soluta rerum. Nostrum laboriosam distinctio aut beatae aut id. Eos debitis deserunt facilis. Sed voluptas quia reiciendis earum.', 1, '1992-07-26 05:52:55');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('46', '66', '49', 'Dolores alias esse minima qui hic. Non rerum perferendis modi. Optio ut id architecto eum autem.', 0, '1999-12-31 13:35:42');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('47', '61', '38', 'Labore voluptatem maiores aliquid nulla nulla velit maiores. Possimus tempora atque possimus sapiente quia aut.', 1, '2018-12-21 15:58:51');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('48', '91', '94', 'Corporis earum eaque vel minus eos. Sed et perspiciatis quia nihil cum ut. Voluptatem non voluptatibus rerum illo hic. Autem quos qui dicta.', 1, '1990-06-06 06:17:16');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('49', '46', '55', 'Impedit id dolorum sunt eum labore sint. Autem aut nesciunt architecto dolore suscipit.', 0, '1972-07-31 12:38:06');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('50', '81', '38', 'Amet at doloribus nam sint qui molestiae. Enim aut dolorum debitis quisquam impedit. Voluptatem natus accusantium repellat repudiandae veritatis atque voluptatem.', 0, '1978-08-07 23:23:52');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('51', '25', '55', 'Eum itaque tenetur quia adipisci. Laboriosam quibusdam et dolorem. Perferendis architecto est velit enim veritatis necessitatibus quia. Earum maxime aut quasi nihil sapiente omnis. Non atque quae officiis eos facilis quo tempora.', 1, '2009-06-30 13:21:40');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('52', '51', '62', 'Ea fugiat nemo quis ea itaque molestiae eum. Ut recusandae sunt quia. Ipsa qui iste eaque tempora corporis est quasi.', 1, '1986-09-27 16:43:32');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('53', '39', '89', 'Sed maiores omnis sunt consequuntur quidem. Et ab et voluptate similique. Debitis unde ut officiis veniam et dolores iusto. Dolore doloribus et amet asperiores ut recusandae deserunt ut.', 0, '1989-03-23 08:04:16');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('54', '11', '75', 'Qui dolores qui omnis incidunt culpa. Consequatur qui numquam tenetur similique ut. Ut qui ratione ut tempore perspiciatis vitae.', 0, '1988-06-06 15:53:50');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('55', '67', '62', 'Enim voluptatem blanditiis quod nihil incidunt. Totam est quam est illum architecto reprehenderit voluptatem. Quidem reprehenderit dolorem quo molestias ut velit dolorum.', 1, '1977-06-17 16:54:49');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('56', '83', '67', 'Voluptatem accusamus nobis dolorem error at ratione. Commodi ut ut quia quam est tempora maxime. Explicabo qui ullam a accusamus tempore.', 0, '2004-08-31 10:08:05');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('57', '50', '72', 'Nemo qui perspiciatis cumque et. Rerum iste officia voluptatum. Corrupti dicta dolorum unde nesciunt. Doloremque autem nisi ea minus quos corrupti.', 1, '1992-07-08 16:41:17');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('58', '25', '61', 'Architecto accusantium quo quod voluptates. Similique at quibusdam impedit qui ut dolorem. Enim non doloribus itaque. Repellat voluptates reprehenderit odio rem.', 1, '2006-07-18 07:37:23');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('59', '61', '12', 'Quasi dolores dicta voluptatem animi. In nemo provident error cumque molestias quam nulla.', 0, '1994-05-20 23:03:37');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('60', '22', '2', 'Harum doloremque dolorem pariatur atque delectus consequatur quis. Ducimus dignissimos nam sed cupiditate. Dolorem totam pariatur et eligendi quaerat omnis aut.', 0, '2002-08-17 17:13:19');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('61', '64', '88', 'Totam alias officia est dolorum impedit cupiditate aperiam. Sed nisi sequi atque omnis doloribus. Quia maxime perspiciatis dolor et ut. Voluptatum eius quam eaque dolores repellendus sapiente debitis.', 1, '1981-07-22 07:13:37');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('62', '50', '24', 'Voluptatum enim harum architecto enim nesciunt. Aspernatur doloremque labore sed odio ad cum ex libero. Repellendus voluptates dolorem architecto nobis aut debitis. Vitae voluptatem placeat voluptas iusto in quasi placeat.', 0, '1971-03-20 05:34:07');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('63', '25', '41', 'Voluptatem commodi et dolores. Consequatur velit incidunt voluptas nobis magnam. Facilis quia molestiae enim corrupti voluptatum.', 1, '1999-06-13 07:01:27');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('64', '17', '71', 'Labore aut sit cumque. Maiores facere quod similique consectetur eos adipisci. Ut atque maxime odio voluptatem exercitationem et.', 1, '1995-06-01 09:05:39');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('65', '95', '97', 'Quam voluptas modi cumque est voluptatem aut. Eos hic reprehenderit non nihil. Totam pariatur ab dolores eveniet et error quia. Vel est quam asperiores sit quibusdam aut doloribus.', 1, '1975-06-30 13:15:55');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('66', '8', '20', 'Nulla et vitae quis et maxime omnis distinctio. Suscipit velit eos qui repudiandae voluptatem quam aspernatur. Nihil temporibus sit at qui voluptatum eos tempora. Ex natus optio explicabo accusamus quis sed inventore.', 1, '2009-09-23 11:49:57');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('67', '51', '58', 'Deleniti nisi amet eaque et et molestias. Facere possimus beatae consectetur facere minima. Animi illo voluptates fugiat vero libero est est voluptatibus. Ut vel soluta et.', 1, '1994-02-22 04:39:19');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('68', '82', '90', 'Consequatur perferendis quia modi perferendis reprehenderit. Omnis similique ut est perspiciatis est omnis sit blanditiis. Nam harum aut ipsa nam animi non.', 0, '1976-04-04 11:53:07');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('69', '47', '92', 'Qui molestiae totam nam reiciendis sequi laboriosam. Doloremque neque qui qui provident accusantium quia. Hic eum voluptates similique cupiditate.', 0, '1992-09-30 14:43:21');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('70', '65', '13', 'In et quo et debitis. Velit quia nam molestiae praesentium similique. Voluptatem commodi veniam aut accusantium.', 1, '1995-02-18 07:12:49');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('71', '54', '47', 'Doloribus earum est ad earum veniam alias. Aut esse autem provident voluptatem incidunt iusto delectus. Et necessitatibus ea accusantium numquam.', 1, '1987-08-01 13:07:21');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('72', '79', '3', 'Unde et eligendi ducimus at perferendis ut. Est aut molestias molestias alias alias. Impedit quo aut ducimus sed porro.', 1, '2019-05-11 07:51:45');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('73', '18', '4', 'Quos facere perferendis et et est. Ab asperiores dolorum provident necessitatibus nihil est. Cum dolorum saepe tempore dolor nisi. Velit eligendi quibusdam et perspiciatis nihil.', 1, '1993-04-17 05:26:08');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('74', '63', '79', 'Voluptatem et voluptatem ipsum asperiores illum explicabo amet. Id veritatis illo quos assumenda magnam. Natus explicabo molestiae dolor est totam tempora suscipit. Facere aut nobis ab qui repellat aperiam animi tempore.', 1, '1980-08-19 19:10:54');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('75', '15', '85', 'Quisquam non aut eum ut maxime id. Pariatur et esse placeat rerum qui amet vero. Soluta est quo vero consequuntur corporis sequi necessitatibus. Soluta rerum officiis et sit totam eligendi.', 0, '2011-04-04 08:56:15');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('76', '80', '78', 'Mollitia accusamus ipsa quibusdam deleniti explicabo doloremque. Rerum repellat hic vel inventore. Rem eius eum et perspiciatis necessitatibus eius ipsa.', 0, '1992-05-31 23:18:57');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('77', '73', '29', 'In tenetur et iure facere veritatis iste. Perferendis reiciendis quia et porro rem perferendis. Quia suscipit repellat ut ut nobis dolores cumque dolore. Vero et veritatis aut nisi.', 0, '1990-04-17 14:43:39');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('78', '2', '97', 'Sed quae odit qui nobis necessitatibus sed ad. Modi similique aspernatur alias sed. Non provident itaque repudiandae odio ut tenetur ut. Aperiam reprehenderit illum at laboriosam quas nostrum recusandae facere.', 1, '1987-01-26 07:23:43');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('79', '69', '18', 'Sunt rerum occaecati esse earum. Officiis ratione doloribus tenetur laborum. Possimus vitae est nisi repudiandae dignissimos distinctio.', 0, '1999-12-01 22:26:25');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('80', '67', '64', 'Molestiae est omnis voluptate ipsa iure aut. Debitis distinctio vel illum distinctio. Ea quaerat voluptatem quidem expedita optio quia molestiae. Culpa facere nihil et eos voluptates voluptatibus aut.', 1, '2012-10-31 00:41:23');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('81', '15', '75', 'Quia ea eum omnis ullam debitis sint sed pariatur. Dignissimos earum vitae ab est. Consequuntur dicta dolore atque assumenda. Praesentium voluptas incidunt ut consectetur.', 0, '1975-10-16 16:33:48');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('82', '83', '66', 'Voluptate sit maxime aliquam sed soluta odio. Quia id veniam consequatur laborum. Commodi esse sunt sit quia error repellat aut.', 0, '2008-06-25 21:58:15');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('83', '33', '64', 'Occaecati ipsum sequi ad et. Itaque modi aut nihil minus non suscipit odio. Quibusdam quis qui rerum ipsa.', 1, '1993-02-15 07:45:21');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('84', '55', '79', 'Voluptatem dolor autem aut dolorem omnis nostrum. Tempora perspiciatis fugiat necessitatibus qui ipsam vitae et. Nulla ad qui quae. Assumenda tempora rerum facilis et esse quas.', 0, '1970-11-23 02:06:21');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('85', '56', '20', 'Sint ducimus consequatur recusandae dolores dolores. Saepe porro perferendis ut laboriosam cum. Debitis repellat iure repellendus labore qui.', 0, '2014-10-08 21:44:59');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('86', '92', '10', 'Veritatis doloribus sit eligendi qui iusto. Aut molestias minima corporis natus et. Omnis molestias necessitatibus quia quia quia aperiam.', 0, '2000-12-17 14:17:55');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('87', '66', '71', 'Nemo animi eveniet sit sint nihil. Officia voluptates est quos est debitis velit quasi. Ipsum at voluptatem sit voluptate distinctio enim recusandae.', 0, '1984-05-31 05:29:54');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('88', '12', '84', 'Iste quasi ut ut qui et. Vel et voluptatem eaque consequatur et quam amet. Autem libero recusandae deleniti illo culpa. Odio recusandae tempora qui.', 0, '1974-08-21 09:48:35');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('89', '74', '75', 'Natus sit sunt iusto voluptatem exercitationem laudantium porro velit. Laboriosam voluptate aut omnis nostrum. Temporibus repellendus voluptatem non voluptas. Officiis nam iure quasi quas et molestiae.', 1, '1982-09-11 18:12:05');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('90', '62', '89', 'Neque necessitatibus itaque eveniet aliquid. Recusandae vitae officia enim aliquam. Consectetur nostrum repellat vitae. Quas earum autem fugiat et debitis molestiae provident.', 0, '2011-10-14 06:54:27');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('91', '60', '42', 'Rerum nihil quibusdam enim dolorum ducimus vero velit. Vel dicta est distinctio dolorum et facere ipsum. Maxime sed optio quasi nihil vero.', 1, '2010-01-05 03:18:13');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('92', '67', '32', 'Aliquid eaque quaerat autem expedita. Suscipit cumque molestiae et sint pariatur nam minus. Quia et aut maxime minima. Illo ullam vero voluptatum accusantium. Quae voluptates nam atque aut.', 1, '2015-11-14 13:34:57');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('93', '70', '68', 'Harum quod molestiae cumque at nihil expedita. Perspiciatis architecto repellat qui et nihil aut et maxime. Eaque molestias alias est esse beatae mollitia.', 0, '2018-09-14 14:40:07');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('94', '28', '39', 'Maiores deleniti recusandae odit repudiandae non nemo error dolore. Inventore sed doloremque tempora voluptatem sunt nulla distinctio.', 1, '2020-06-11 20:09:39');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('95', '86', '95', 'Rem eum velit maiores nobis totam doloribus. Voluptas dolore est sapiente incidunt optio. Nam voluptatibus sit debitis error. Ipsam laborum dolores repellat qui et debitis.', 1, '1978-03-26 21:13:08');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('96', '2', '100', 'Laudantium alias perferendis et soluta doloremque in et. Ea sit dolorum nobis voluptas voluptas sint explicabo. Odio omnis eos saepe dolorum ipsam consequuntur. Dicta nulla eligendi aspernatur nesciunt modi.', 1, '2010-05-03 07:08:50');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('97', '69', '85', 'Similique necessitatibus qui adipisci. Reiciendis maiores omnis distinctio necessitatibus. Voluptas voluptatem optio est perspiciatis voluptatem nesciunt. Aut itaque repellat consequuntur molestiae sit.', 1, '1999-12-31 06:14:21');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('98', '65', '2', 'Harum nostrum temporibus blanditiis esse molestias ut culpa. Illo iste ab ullam voluptate doloribus explicabo. Ut maxime tempora velit quaerat labore soluta. Voluptatem animi voluptas ea omnis deleniti.', 1, '1970-06-02 16:25:12');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('99', '49', '20', 'Dolores expedita necessitatibus aut eum qui est voluptas. Sed dolores rerum pariatur sunt vero fugiat. Velit non aut eligendi harum id. Sit cum illum numquam quae.', 0, '2005-12-16 16:42:12');
INSERT INTO `message` (`id`, `from_user_id`, `to_user_id`, `message`, `is_read`, `created_at`) VALUES ('100', '80', '4', 'Reprehenderit voluptas consequatur voluptates ut ut magnam beatae. Maiores cum perferendis reiciendis enim. Consequatur cumque modi ratione provident rem suscipit ullam vel. Mollitia sed libero omnis consequatur quia sapiente.', 0, '1974-08-21 06:46:31');

INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('1', 'commodi', '1', 'Consequatur expedita ut velit aperiam ratione voluptatibus quia commodi. Qui provident magni accusamus qui amet rerum. Et autem quaerat dolorem perferendis blanditiis voluptas et. Impedit enim a consequatur ea accusantium.', '1980-03-23 10:09:33');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('2', 'numquam', '2', 'Nihil praesentium voluptatem nesciunt quis. Esse quo qui fuga quisquam et ut. Molestiae quo ut sit eos ducimus adipisci quibusdam.', '1988-06-07 16:18:34');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('3', 'est', '3', 'Velit saepe et expedita quod. Fugiat officia eum dolores. Nihil corrupti ut maxime in quisquam. Vel assumenda fuga maxime voluptatem aut.', '1982-02-01 18:54:40');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('4', 'cum', '4', 'Quia vel earum quia soluta deserunt enim unde. Impedit nihil doloremque doloremque magni tempora saepe. Deleniti ducimus tempora repellat libero quia provident inventore.', '2010-09-26 15:21:39');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('5', 'placeat', '5', 'Consequatur eum qui reprehenderit minus ullam placeat quo dolore. Similique delectus recusandae qui accusantium. Eos mollitia saepe blanditiis sunt.', '2007-10-29 05:40:11');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('6', 'est', '6', 'Consequatur animi quasi ut sit. Libero iste dolore dolorum sunt placeat totam. Delectus molestiae eaque aliquid aut aliquam eum alias in.', '2018-12-04 02:52:50');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('7', 'perspiciatis', '7', 'Voluptas reiciendis esse quod temporibus sunt. Et praesentium dolores ut vero corrupti ut. Non quas earum alias culpa et.', '2011-10-02 06:36:27');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('8', 'sit', '8', 'Qui est explicabo voluptate. Necessitatibus sequi eaque ut distinctio aut vel. Molestias ea officiis consectetur consequatur nisi. Quas magni qui quia minima accusamus minima. Odio nihil illum quae perspiciatis voluptatibus corrupti.', '1973-10-11 23:45:48');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('9', 'ut', '9', 'Molestiae voluptatem ut pariatur adipisci ut molestiae molestias. Accusantium aut natus labore sint.', '2018-04-03 07:50:54');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('10', 'repellendus', '10', 'Rerum et aperiam ut praesentium voluptatem rem est dicta. Cumque rerum officia rerum laboriosam omnis officia similique. Nesciunt ullam consequatur odio quia est et dicta eligendi.', '2012-04-22 18:14:16');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('11', 'placeat', '11', 'Quasi qui dicta voluptatibus quis ea inventore et. Commodi tenetur perspiciatis amet et repudiandae est asperiores explicabo. In aperiam quis possimus dolore exercitationem laboriosam. Modi dolores omnis rerum omnis cupiditate sapiente modi.', '2003-10-21 18:21:58');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('12', 'dolor', '12', 'Sit quam suscipit enim maxime. Ea nobis voluptas at. Velit voluptas officia eaque et vitae deserunt. Laudantium eos repellat excepturi sit repudiandae molestias. Consectetur quae sequi quidem velit non est hic.', '1989-07-03 15:40:23');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('13', 'repellendus', '13', 'Ab dolores est et non sit impedit. Delectus commodi inventore vitae velit quo voluptatum. Quod dolor culpa dignissimos dolorum qui sed.', '1999-04-08 14:43:36');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('14', 'sapiente', '14', 'Dignissimos itaque ut eius et eum voluptas. Molestiae dolores ex nostrum nihil enim aut vero nulla. Voluptas omnis aliquid minus quos aut tempore corporis quia. Placeat molestias inventore ad recusandae esse laboriosam.', '2019-11-03 13:02:32');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('15', 'fugit', '15', 'Sit magni asperiores molestias alias. Perferendis numquam aliquam consequuntur ab id maxime blanditiis. Ratione accusantium quis aliquam sed modi doloribus. Ipsam cum nihil labore corporis officia.', '1980-04-26 02:24:03');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('16', 'molestiae', '16', 'Eos doloremque velit minus ipsam corrupti. Ut quam officia voluptate suscipit aut natus. Incidunt nihil officiis omnis explicabo laborum et sequi consequatur.', '2006-01-30 00:22:22');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('17', 'labore', '17', 'Quaerat voluptatem itaque fuga provident et dicta earum. Placeat est velit et aut. Voluptatem itaque et delectus voluptatem rerum. Natus ipsa minus maxime laborum.', '1977-01-03 11:23:00');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('18', 'sit', '18', 'Et nisi atque quo distinctio eveniet ut atque doloremque. Iure cumque voluptas tenetur rerum mollitia officiis et. Dolore provident praesentium repellendus sunt repellendus enim dignissimos. In aperiam consequuntur dolore aliquid praesentium laborum doloribus ullam. Omnis hic dolore omnis fugiat tempora velit.', '1990-05-08 01:11:19');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('19', 'non', '19', 'In est non quaerat aut non est. Quaerat qui ex quae. Nobis illum quos odio omnis dolorem voluptatem rem. Veritatis dolorem nostrum ullam reiciendis.', '2018-09-18 20:44:55');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('20', 'atque', '20', 'Perspiciatis est vero fugiat debitis qui neque. Necessitatibus non illum sunt rerum inventore totam. At repudiandae dolore voluptates laudantium repellat esse aut. Voluptas voluptatibus mollitia deleniti sit laudantium. Veniam saepe nesciunt sequi nemo.', '2016-03-26 06:27:20');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('21', 'voluptatem', '21', 'Natus cum doloremque rerum sunt animi sint sed. Unde rem totam totam quo aliquid. Quas quo et rem dolorum amet atque est.', '1994-01-13 23:54:38');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('22', 'eum', '22', 'Velit debitis soluta debitis a maiores. Numquam modi incidunt adipisci aut. Et molestiae modi accusamus aliquid est sint non.', '2020-01-29 16:38:55');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('23', 'magni', '23', 'Consectetur dolorum vel et reiciendis similique. Omnis voluptatum expedita blanditiis eos vero. Qui velit et repudiandae saepe nulla quis dolor. Nisi aliquam officia repellendus et. Voluptas reiciendis qui magni cumque quis repellat.', '1987-10-30 11:25:30');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('24', 'mollitia', '24', 'In necessitatibus neque explicabo. Qui est nemo id et cum aut. Reiciendis nam vel voluptatem ipsum ex autem. Est consequatur qui iste voluptas.', '1974-08-04 11:54:45');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('25', 'alias', '25', 'Saepe eos nesciunt minus. Ipsam cumque veritatis et quia. Qui voluptatem vel officiis dolores deserunt nihil. Eveniet vel voluptatibus qui odio.', '2012-04-30 15:51:01');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('26', 'enim', '26', 'Non omnis voluptas ducimus consectetur. Necessitatibus sit non ut corrupti eum. Culpa ut porro consequatur.', '1983-06-27 18:22:12');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('27', 'et', '27', 'Ipsam autem praesentium autem iure nesciunt sed quia. Eius quis minima adipisci et. Non facilis ut ipsam vel. Ut incidunt enim et rerum illo dolores. Libero ut excepturi ut quasi nihil.', '2017-07-03 05:27:27');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('28', 'molestiae', '28', 'Et asperiores hic praesentium fugiat. Consequatur explicabo voluptatum error. Consectetur nulla expedita quos non quasi.', '1974-09-11 22:14:58');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('29', 'eos', '29', 'Aut sed fuga temporibus a. Nihil est ea aliquid veniam debitis omnis.', '1978-03-31 19:53:31');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('30', 'nostrum', '30', 'Velit aut aut enim alias nesciunt nam fugit. Alias reprehenderit optio amet quisquam reiciendis sit eos. Non earum rerum velit atque dolore. Molestias quia voluptates occaecati rem nihil.', '2000-03-18 19:14:46');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('31', 'quia', '31', 'Consequuntur et eos beatae delectus et totam rem laborum. Eligendi sunt esse ea quidem harum. Voluptate velit itaque ipsa sequi est earum. At voluptatem itaque ex esse in.', '1979-05-06 01:38:04');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('32', 'occaecati', '32', 'Reiciendis voluptate ullam non et minima sit. Ut natus quos saepe. Reprehenderit voluptatem facere vel dignissimos ipsam sint eius.', '1991-07-09 20:16:37');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('33', 'ut', '33', 'Culpa ducimus eos cum animi ut ullam. Suscipit nam et pariatur. Enim ducimus quos reprehenderit quae est velit.', '1979-05-19 13:23:21');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('34', 'eligendi', '34', 'In quia cupiditate ad deleniti id. Qui sint beatae odio ipsa animi. Illum architecto neque sit eaque eos.', '2007-09-02 09:16:44');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('35', 'enim', '35', 'Odio enim quo doloribus aliquam. Sint facere culpa laboriosam iusto.', '1987-09-21 08:23:42');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('36', 'voluptatem', '36', 'Tempore dignissimos aut nostrum excepturi accusantium exercitationem. Labore voluptatem voluptatum at ipsum. Optio enim ex ut.', '2013-06-24 13:00:59');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('37', 'nam', '37', 'Eveniet corrupti quis temporibus quia necessitatibus totam quia deleniti. Veritatis facere ratione dolor dolor deserunt autem. Autem veniam suscipit libero.', '1979-07-29 10:05:55');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('38', 'omnis', '38', 'Rerum qui distinctio unde illum. Nesciunt ex similique molestiae enim quibusdam earum. Earum atque perspiciatis quo nostrum vero.', '1976-06-28 10:32:31');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('39', 'et', '39', 'Est tempora quia voluptate aut. Et reiciendis reprehenderit ducimus voluptate repudiandae quo accusantium. Doloremque voluptatem provident nemo numquam consequatur id. Quia deserunt totam animi repellendus necessitatibus vel.', '1995-12-16 14:21:46');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('40', 'deserunt', '40', 'Quia suscipit fuga ducimus qui. Aut nam aperiam harum delectus facilis error. Non dolorem reprehenderit culpa officiis. Et quia at reiciendis.', '1986-07-05 21:32:59');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('41', 'repellendus', '41', 'Eligendi vitae magnam totam. Quia voluptas laboriosam sunt eveniet maiores rerum ut. Quibusdam molestias enim culpa ipsum quam et aperiam accusamus.', '1972-04-27 22:03:37');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('42', 'voluptas', '42', 'Et ipsum vel qui distinctio. Ratione quia et dolorem necessitatibus minus mollitia. Inventore ut qui tempore sunt eligendi. Nobis ad velit reiciendis cum corrupti.', '2020-08-06 15:42:36');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('43', 'quia', '43', 'Dolorum consequatur nisi aut eligendi quas ducimus fugit. Eum quibusdam repellat aspernatur earum. Totam illo autem incidunt. Aut quia sapiente qui sed.', '2013-01-17 20:11:29');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('44', 'fuga', '44', 'Sunt eaque saepe quis et error. Sint in illum aperiam non. Sunt quisquam inventore modi dolore nulla expedita. Fuga ea iste consequatur earum.', '2018-03-21 03:57:30');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('45', 'molestiae', '45', 'Dolores aliquid eveniet ullam labore doloribus vel. Molestiae et in est quia voluptatibus. Ullam quae iure reiciendis repellat amet.', '1972-09-02 19:31:07');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('46', 'quia', '46', 'Magnam sunt sit qui qui suscipit reprehenderit esse. Labore minus consectetur enim. Hic eligendi autem culpa officiis.', '1995-08-26 21:46:37');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('47', 'animi', '47', 'Voluptates eum cumque aliquid quod commodi cumque. Voluptas enim asperiores ut similique voluptates est sit dignissimos. Laudantium dolorem minus est eos omnis. Dolores accusantium corrupti et sunt.', '1997-02-10 03:16:14');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('48', 'culpa', '48', 'Illum doloremque nesciunt et aperiam. Qui aut eaque vero blanditiis sunt sint repellat. Sed est sit in ut quasi eligendi eos. Fuga amet eos pariatur animi optio ex.', '1998-11-16 18:27:23');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('49', 'nam', '49', 'Perspiciatis autem vel qui sunt. Recusandae non quasi quam aut qui culpa quibusdam ex. Et ea impedit quam officiis. Officiis odio minus aut tenetur voluptatem.', '2003-04-12 08:55:54');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('50', 'ad', '50', 'A deleniti nulla qui quia ab debitis velit. Ab et reiciendis dolore repellendus eos et est.', '1992-09-07 17:42:29');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('51', 'qui', '51', 'Modi vero pariatur corporis corrupti ut nam. Sunt distinctio officia pariatur voluptatem aspernatur quam aut. Omnis dolorem ex aliquam harum est nulla.', '1984-05-12 02:37:57');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('52', 'dolor', '52', 'Distinctio iure numquam dolores. Voluptas doloremque est deserunt animi consequatur eum et. Deserunt modi numquam et perferendis.', '1988-08-18 11:24:12');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('53', 'nisi', '53', 'Qui cupiditate accusamus neque ut eum soluta cum. Dolorem quo reiciendis perferendis nobis rerum sequi. Enim possimus et dolorum ad sequi maxime. Velit et vero quidem facilis reprehenderit id.', '1971-03-13 09:52:53');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('54', 'corrupti', '54', 'Quia officiis qui aut aut qui aut. Quae iste ut quibusdam ipsam. Nobis minus labore hic hic eos ut iusto rerum.', '2020-11-14 21:25:12');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('55', 'pariatur', '55', 'Cupiditate vitae sequi explicabo eligendi et iure architecto. Autem cum ad ipsa quas. Rerum minus cum expedita aliquam asperiores mollitia et. Officiis vel recusandae qui est quibusdam itaque eveniet.', '1974-02-07 11:19:38');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('56', 'debitis', '56', 'Repellendus eligendi quam et sapiente in. Natus esse aperiam vitae ut est placeat. Labore consectetur enim necessitatibus voluptas ut et cumque. Qui minima laboriosam sed magnam qui. Veritatis quas iusto non id libero non.', '1973-12-23 09:22:36');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('57', 'possimus', '57', 'Molestias quae dolor excepturi molestiae. Magni voluptates optio commodi cupiditate sunt et aut harum. Vel doloremque repellat est eos fugit quia odio. Doloribus et sit sed omnis vero ut fugiat. Aliquam maxime sed est et.', '2012-12-19 20:00:38');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('58', 'nulla', '58', 'Debitis eum dicta vitae voluptas alias. Aut cum modi distinctio omnis necessitatibus nesciunt.', '1974-11-09 01:05:49');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('59', 'et', '59', 'Iure hic esse ipsum aut excepturi. Alias voluptates placeat rem pariatur omnis suscipit. Non aut quos perspiciatis minus quibusdam numquam. Iusto veritatis soluta nemo.', '2002-03-26 18:37:30');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('60', 'non', '60', 'A amet eos ea. Deleniti repellendus voluptatem ut nostrum inventore iure occaecati. Tempore quas architecto assumenda ipsa ipsa aut doloribus.', '1983-02-07 09:02:57');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('61', 'voluptatem', '61', 'Dolore quae aut pariatur voluptatem. Fugit voluptas et beatae pariatur aut sit. Et eum non est nihil minus ut.', '2010-07-03 20:59:50');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('62', 'enim', '62', 'Est commodi exercitationem provident officiis voluptatem itaque quidem. Dolore accusamus magni consequatur exercitationem dolor enim asperiores. Quidem consequatur atque occaecati neque autem quidem nihil id.', '2012-12-18 12:09:03');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('63', 'accusantium', '63', 'Velit et et et deserunt. At tenetur dolorem laborum eaque. Ipsum inventore atque debitis esse nam est eum.', '2011-07-28 19:00:59');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('64', 'reiciendis', '64', 'Minus deserunt et facilis doloribus et eum. Voluptatem ipsum dicta et. Sit est sed qui ipsa sunt voluptates quidem. Neque et quasi ut molestiae doloremque temporibus.', '1998-08-23 17:29:45');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('65', 'consequuntur', '65', 'Iure blanditiis eos adipisci maiores qui. Debitis autem in inventore possimus. Culpa expedita fuga necessitatibus qui ducimus. Eos necessitatibus cupiditate eum dolorem tempora. Commodi libero voluptatibus in iure.', '1977-12-08 14:53:56');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('66', 'dolores', '66', 'Aliquam nostrum pariatur et delectus consequuntur. Iste in est nobis sed eligendi et tempora. Qui voluptatem omnis nobis commodi voluptas unde. Neque voluptas illo ut sunt.', '2016-10-11 18:30:35');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('67', 'veritatis', '67', 'Sint inventore occaecati fugit ullam. Dolorem omnis voluptatem ut accusamus sint aut dolores. Enim et ullam perspiciatis consequatur incidunt. Nam qui ad odio exercitationem reprehenderit aut magni. Et excepturi ut accusamus iusto harum expedita.', '1986-07-18 19:40:47');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('68', 'nemo', '68', 'Libero commodi veniam suscipit quo. Minus qui omnis voluptas dignissimos quo.', '1989-02-13 11:32:00');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('69', 'et', '69', 'Rerum sint ex ipsa est. Facilis accusamus assumenda similique soluta.', '1997-01-29 06:16:35');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('70', 'et', '70', 'Itaque accusantium alias qui ipsa veniam ut quae ea. Aut necessitatibus rerum vitae a sed eum quasi. Quis officia nulla rerum accusantium est. Temporibus incidunt voluptatibus facilis iste delectus maiores magni.', '2005-03-31 01:43:42');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('71', 'ut', '71', 'Et beatae et voluptatem eveniet. Deleniti officiis voluptate tempore rerum et aspernatur id modi. Dignissimos excepturi rerum et saepe voluptatem. Ea incidunt voluptatum eos.', '1973-11-03 20:35:37');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('72', 'dolore', '72', 'Et et qui delectus. Quos perspiciatis non sequi ut illum et quis. Culpa odio quam quia ad.', '1971-08-28 18:23:44');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('73', 'commodi', '73', 'Et numquam et neque molestiae numquam natus blanditiis. Nulla eos minus dolor itaque dolorem labore et accusantium. Quis dolorem occaecati natus repellendus qui dolores nemo. Voluptas rerum est dolorum est.', '1994-03-31 19:11:49');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('74', 'earum', '74', 'Vel consectetur necessitatibus et dolores nulla non ea. Velit perferendis vitae sapiente impedit reiciendis. Nihil autem ea quidem temporibus dolorem sit illum.', '2014-10-22 20:49:47');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('75', 'laudantium', '75', 'Qui harum ex veritatis et. Magni rerum provident et sapiente consequuntur et.', '2012-10-10 03:07:11');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('76', 'dicta', '76', 'Libero est et molestiae rerum eius rem sapiente. Fugit itaque perspiciatis voluptatem sint. Doloribus saepe voluptatem nulla dolores consequatur et.', '2003-04-04 18:46:00');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('77', 'sequi', '77', 'Consequatur id et rerum commodi iste. Nulla error ut maxime.', '1997-04-07 00:13:12');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('78', 'asperiores', '78', 'Similique quisquam ut id consequuntur. Et velit deleniti sint harum. Consequatur ut illum cum itaque.', '1983-04-30 03:41:51');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('79', 'cum', '79', 'Explicabo alias perspiciatis nostrum asperiores culpa. Sapiente dolores magni cupiditate rerum minima cumque. Expedita dolores explicabo eum et repellendus nesciunt. Officiis id totam et molestiae ullam.', '1984-10-16 05:44:49');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('80', 'corporis', '80', 'Sunt explicabo laborum in aut. Placeat id odio aut quo debitis. Dignissimos beatae esse quae eos ex mollitia.', '1989-03-03 22:37:00');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('81', 'repellat', '81', 'Consequatur nobis illum quis atque quo delectus. Dolorem sed in sunt quas animi deleniti neque. Corporis qui vel sint tenetur et officiis veritatis quia. Deleniti illo molestiae eaque.', '1987-09-25 20:30:26');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('82', 'perferendis', '82', 'Nulla quod aliquid velit ut quia. Dolores et quos labore et reiciendis et vel. A est commodi et autem ab natus.', '1985-04-10 05:00:26');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('83', 'cum', '83', 'Non unde fugit aut saepe itaque ut. Est repellat sint excepturi voluptatem ducimus qui quia sed. Et dolores ut et eum ut.', '2000-11-10 13:42:02');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('84', 'dolor', '84', 'Et vel ipsam excepturi. Vel architecto saepe quo illo est expedita vel molestias.', '2008-11-13 22:45:25');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('85', 'esse', '85', 'Quae est est repellat eos voluptatibus quia amet. Dolor in autem accusantium officiis deserunt. Quisquam sequi maxime dolore non qui quia.', '2015-12-01 19:53:23');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('86', 'odio', '86', 'Voluptatem eius facilis omnis soluta. Dignissimos voluptates voluptas nihil atque reprehenderit dolores dolores. Voluptas accusantium maxime voluptatem quas et et quibusdam. Laborum mollitia odit et dolores aut eligendi.', '2000-09-05 03:36:50');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('87', 'a', '87', 'Consectetur veniam non vel laudantium impedit. Iusto reiciendis omnis aspernatur sed optio reprehenderit et. Hic est laboriosam reiciendis doloremque atque qui totam. Ullam et nesciunt dolorem neque aut placeat voluptate.', '1992-09-28 22:44:48');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('88', 'debitis', '88', 'Quia eligendi deleniti qui accusamus est. Recusandae aut sunt occaecati vero qui aut ipsam. Quasi consequuntur aspernatur in quia necessitatibus dolorem nostrum. In blanditiis quia molestias at dicta.', '1998-05-31 22:08:42');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('89', 'ut', '89', 'Doloremque quidem sunt sint nobis labore tempora. Delectus quibusdam enim quibusdam ipsum et corrupti aut animi. Laudantium aut laudantium impedit et quis sequi non. Dolores nulla aliquam quo fugiat.', '1989-07-05 00:03:15');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('90', 'magni', '90', 'Ea reprehenderit at maiores ipsum occaecati. Eligendi dolorem sed illo reiciendis qui delectus qui animi. Ut nihil eos et odit fugit temporibus quidem.', '2019-08-22 08:36:08');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('91', 'nisi', '91', 'Ut blanditiis totam beatae adipisci consequatur optio. Id cumque vel quo adipisci culpa sit velit. Minima officia et est. Ea voluptas provident eum laborum provident.', '1989-04-20 22:50:11');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('92', 'et', '92', 'Nemo distinctio optio aut ut. Quos quod ab eaque. Neque id a facilis asperiores ipsum sed. Nam repellat repellat excepturi sapiente voluptates consequatur numquam.', '1983-08-18 16:29:06');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('93', 'et', '93', 'Accusantium rerum accusantium fuga ut nobis atque. Omnis dolores officia earum mollitia incidunt. Unde optio atque tenetur vitae aliquam officiis consequuntur. Reprehenderit et optio unde ducimus tempore. Ut earum laudantium non nihil quisquam.', '2019-10-13 09:27:48');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('94', 'esse', '94', 'Quod eaque corrupti adipisci delectus ut. Est corrupti occaecati hic. Fugiat labore excepturi quia ea enim quia eum.', '2012-08-01 09:46:57');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('95', 'sed', '95', 'Repudiandae sequi quidem assumenda sequi cum et et. Neque tempore culpa ut repudiandae. Natus facilis quia qui maxime magnam pariatur eos ex. Ipsum tenetur esse fuga illo nam voluptates eveniet.', '2018-07-07 11:44:52');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('96', 'blanditiis', '96', 'Nesciunt expedita labore numquam rerum. Quis voluptatem dolores et. Ut aspernatur dolore numquam delectus eos.', '1973-11-19 16:48:32');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('97', 'est', '97', 'Ducimus fuga repellat sunt iusto quos dolores. Ea qui totam totam ea. Laboriosam eaque dolor iure numquam veritatis quasi. In consequatur ut tempore enim rerum aliquid expedita atque.', '2011-09-07 21:01:57');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('98', 'voluptates', '98', 'Ea deserunt sed accusantium aliquam enim omnis aut quia. Doloribus rerum iure quia earum aperiam nulla. Magni animi eveniet quam sit minima ratione.', '1988-10-25 15:41:59');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('99', 'sint', '99', 'Quia quia deserunt nihil et ut aut harum ut. Et est alias omnis commodi et iure laborum. Nam quia autem eius est earum quia pariatur.', '2011-02-19 07:16:27');
INSERT INTO `photos` (`id`, `file_name`, `user_id`, `description`, `created_at`) VALUES ('100', 'ipsum', '100', 'Ipsa et ducimus reiciendis sequi quo ullam. Nulla doloribus ut nostrum numquam non aut. Neque non quam eaque autem saepe ut voluptates. Fugiat deleniti laboriosam tempora perspiciatis.', '2020-09-24 13:02:15');

INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('1', '1', 'Assumenda sed repudiandae nemo accusamus rem nisi. Quibusdam exercitationem molestiae occaecati rem mollitia est sit laborum. Et non a omnis. Est ducimus reprehenderit distinctio veniam qui neque.', '1989-08-13 15:13:12', '2005-11-07 06:03:31');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('2', '2', 'Aliquid et et ratione delectus. Voluptatibus in necessitatibus eveniet. Illum et unde quis unde consequatur facilis est. Ipsum enim doloribus non nulla qui excepturi explicabo.', '2020-02-05 10:54:54', '1971-11-14 11:22:45');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('3', '3', 'Illo voluptas quas quibusdam accusamus. Molestias enim dolores autem aliquam. Velit ut delectus delectus consectetur nobis.', '1991-08-16 15:00:18', '1978-11-17 06:33:59');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('4', '4', 'In ea deleniti ex. Eum ut deserunt facilis magnam eum. Corporis sit qui sit eaque numquam commodi aliquid.', '1987-07-03 06:41:25', '2006-05-15 06:41:59');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('5', '5', 'Sunt exercitationem in enim et modi. Id alias quae iste porro iusto quas. Et quisquam velit distinctio voluptas nisi. Deserunt reprehenderit est optio dicta porro voluptas nesciunt harum.', '1980-10-20 14:20:16', '2005-03-15 20:50:55');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('6', '6', 'Molestiae quibusdam perferendis qui voluptatem. Deserunt facilis est porro temporibus.', '1979-12-16 23:49:59', '1996-03-15 09:34:56');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('7', '7', 'A omnis est corrupti ex. Libero minima porro ut suscipit.', '1977-04-10 13:52:18', '1971-06-11 22:07:47');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('8', '8', 'Beatae et possimus laboriosam. Ut dignissimos fugiat autem adipisci eius harum unde. Quae non atque consectetur et corporis sequi dolorem sed.', '2012-06-02 16:22:44', '1989-01-14 21:39:11');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('9', '9', 'Omnis et et ut illum sit. Iure laboriosam alias odit aut eius ut deserunt. Et odio error perspiciatis tempore veniam explicabo.\nDignissimos ut vitae fugit. Eum dolor labore quia ratione voluptas.', '2001-05-31 11:01:47', '1983-12-26 08:42:12');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('10', '10', 'Quia qui id et voluptate illum. Unde non alias labore saepe eum quia. Sed accusantium architecto deleniti totam ut soluta et corrupti.', '1994-10-18 03:27:13', '2001-10-15 18:58:02');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('11', '11', 'Ad et aliquam rem at quis. Consequatur vel nostrum quae omnis animi sint quasi accusantium. Qui soluta dolore aperiam magni unde at. Voluptas maxime nihil quia quisquam est.', '1991-06-19 09:07:38', '2002-05-27 15:22:46');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('12', '12', 'Ut nostrum sit iure necessitatibus est cum. Enim modi quia nihil doloremque natus. Ut deleniti numquam ex.\nQuasi aut et voluptates harum quisquam. Voluptatem et dolorum dolores id.', '1988-09-10 02:49:12', '1998-09-11 06:46:33');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('13', '13', 'Magni expedita minima dolore sint ratione. Qui animi odit corrupti enim magni. Numquam qui rerum ullam aperiam esse.', '1982-09-22 04:00:11', '1977-10-26 13:07:52');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('14', '14', 'Asperiores ab incidunt qui. Eum non voluptatem corrupti quis. Quos odio amet possimus et autem ipsum id.', '1995-02-02 13:17:36', '2008-10-06 06:52:50');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('15', '15', 'Occaecati suscipit enim ad sunt excepturi. Aperiam molestiae consequatur doloribus autem. Quia sit qui illo rem quaerat qui. Quas consequatur iure et in est minima error ea.', '1986-06-13 22:07:44', '2016-04-15 07:14:38');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('16', '16', 'Magni est maxime consequatur minima ea suscipit. Sed labore autem ut magnam temporibus. Earum dolores ab libero voluptas.', '1984-01-27 22:16:24', '2017-02-13 09:32:17');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('17', '17', 'Delectus laudantium et consequatur. Velit et nesciunt aut nihil consectetur. Culpa ab dolores velit eaque in quia nostrum. Sunt quidem esse eum earum fugiat.', '1987-06-13 09:23:07', '1977-02-11 00:02:04');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('18', '18', 'Nostrum inventore doloribus rem error debitis dicta sed. Voluptate tenetur est tenetur impedit non qui et in. Vitae aut magni voluptatem alias ex aspernatur. Et rerum qui sint.', '1985-05-20 11:17:25', '1977-04-19 19:40:33');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('19', '19', 'Sit at voluptas fugiat culpa omnis laborum. Nam animi error blanditiis autem doloremque. Iusto quia cupiditate nihil sunt voluptatum. Rerum est necessitatibus laborum ut.', '1988-05-17 22:28:36', '1971-10-18 12:47:23');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('20', '20', 'Aut voluptatem quasi enim ut unde. Velit dolorem aliquam dolor vero iure. Illum deleniti odio sint est laudantium. Nihil amet sequi totam voluptatem reprehenderit sed.', '2018-05-19 01:41:06', '2014-08-30 03:33:54');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('21', '21', 'Dolores tempora eum iusto magnam omnis eum consequatur. Cupiditate adipisci corrupti delectus odit rerum dolor. Molestiae assumenda quis aliquid sit aliquam asperiores cupiditate.', '1987-11-03 11:47:40', '1999-05-15 04:48:35');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('22', '22', 'Dolorum et quaerat eum beatae praesentium rerum qui qui. Ex perspiciatis molestiae non consequatur est. Ducimus deleniti ipsam tenetur dolore laudantium voluptas. Quod hic minima consequatur quidem.', '1988-11-06 17:14:50', '1998-01-13 13:57:14');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('23', '23', 'Quia nesciunt sit sunt fugiat voluptas sunt. Itaque odio debitis natus omnis consequatur. Ipsa voluptas mollitia dicta doloremque sapiente accusamus et. Iusto voluptatem voluptatem qui.', '2012-08-27 21:24:49', '1990-07-01 20:43:27');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('24', '24', 'Temporibus reiciendis voluptatem consequuntur sit. Ut aut quia qui voluptatem. Iusto est adipisci laudantium distinctio reprehenderit aut. Quas animi voluptas voluptatem qui et dolores voluptatem.', '2015-10-28 05:16:20', '2018-03-15 05:04:30');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('25', '25', 'Quibusdam illum eligendi earum tempora. Porro amet qui ut repellendus fugit. Sint non eum sit.', '2004-07-24 12:38:09', '2006-02-18 20:11:07');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('26', '26', 'Est asperiores quo ad similique quae. Omnis nihil consequatur est voluptatum nulla sunt. Asperiores voluptatum et cupiditate corporis ut nulla.', '1978-01-29 22:08:27', '1982-05-06 16:26:22');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('27', '27', 'Accusantium dolorem et dicta similique ducimus ut. Maiores ut fuga earum nemo quos velit omnis. Beatae dolorum ratione qui non modi doloremque ut.', '2020-05-29 08:38:17', '1986-05-10 07:54:48');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('28', '28', 'Animi tempore provident sed error dignissimos omnis exercitationem mollitia. Modi ut nulla consequuntur. Maxime sapiente quo dolor ipsum. Vel est aspernatur vel neque.', '2017-01-15 11:49:50', '1971-08-17 22:20:59');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('29', '29', 'Hic quasi aut sunt quam hic. Non nisi voluptate rerum dicta ea hic quas.', '2007-08-15 20:44:46', '2018-05-30 01:25:57');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('30', '30', 'At dolorem molestias sunt. Quasi veritatis ut qui dolorem. Quod ipsum eaque est.', '2015-08-12 20:51:21', '2002-12-28 08:24:54');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('31', '31', 'Ut vel voluptatem excepturi voluptate ea et. Officia omnis velit et temporibus ad. Id consequatur qui voluptas libero sit. Dolores ut officiis magnam.', '2006-05-31 15:08:36', '2018-05-12 16:08:40');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('32', '32', 'Et iste ab sunt et dolores nihil iure. Voluptas excepturi doloremque omnis vel blanditiis aut labore. Est aspernatur magni dicta quia nobis sapiente ab quis.', '1986-12-04 07:43:29', '1996-07-27 20:07:53');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('33', '33', 'Sunt aliquam reprehenderit est non totam molestiae optio. Laborum numquam sunt autem et accusamus nihil aliquam. Sit laborum laboriosam libero ex voluptatum.', '2001-04-18 03:26:54', '2002-05-15 02:46:32');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('34', '34', 'Pariatur id nihil sunt sit non animi. Omnis quasi et fugiat. Veritatis velit nemo quasi. Quia quasi eveniet sequi et at temporibus. Nemo velit eos rerum qui.', '1982-10-20 10:27:56', '2009-11-07 17:04:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('35', '35', 'Iusto aut quisquam omnis necessitatibus maiores. Vel occaecati placeat eius sapiente qui itaque eius. Ratione hic quibusdam est enim modi.', '2015-04-22 04:11:49', '1985-07-06 03:32:14');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('36', '36', 'Distinctio et pariatur ea quasi sint velit aut tempora. Nisi doloribus voluptates soluta voluptatum dolores ex. Fugit sit ab voluptatibus itaque consectetur.', '1987-03-04 18:10:36', '1978-05-22 07:14:31');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('37', '37', 'Ut alias id dolor sunt qui possimus. Non deleniti maxime porro debitis id et. Aliquid nemo autem est veritatis.', '1986-09-03 02:00:59', '1982-06-12 00:48:24');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('38', '38', 'Non sed aut ullam dolores quia aut quo. Accusamus quasi optio quae in voluptatibus est veniam. Voluptatem consequatur dolorum quo et aut.', '2000-07-04 15:38:53', '1972-01-07 06:08:36');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('39', '39', 'Nostrum laborum sint id eos dolorem voluptas enim. Et sunt ut atque quas recusandae. Et laudantium voluptatibus ea praesentium veniam. Corporis aliquid dolore excepturi corrupti quos incidunt vero.', '1985-07-14 18:44:11', '1994-02-21 05:54:12');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('40', '40', 'Blanditiis labore esse eum blanditiis labore. Nobis id quaerat nam quisquam autem. Nulla quidem tempora minus et accusantium quisquam. Quo ratione fugiat id qui perferendis neque.', '1985-02-28 15:32:52', '1973-05-26 07:52:13');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('41', '41', 'Fugit nulla at fugiat quia qui quia. Exercitationem deserunt fuga et et magni et nam. Dignissimos quos quo velit officia. Blanditiis pariatur quos alias aut aut omnis.', '2006-12-19 15:47:00', '1987-11-03 05:40:17');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('42', '42', 'Sunt officiis exercitationem expedita eveniet et. Ipsum vero fugit dignissimos et quasi quo ut. Et repellat quia est doloribus.', '2018-09-10 01:32:52', '2007-10-28 21:01:53');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('43', '43', 'Nobis nesciunt et quam neque. Necessitatibus ut quibusdam mollitia officiis sunt. Voluptatem praesentium nam ratione non eius. Sint et nisi architecto deserunt.', '1985-04-28 06:54:53', '1991-09-27 10:16:01');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('44', '44', 'Accusantium nostrum quia quas temporibus et nam. Voluptatem distinctio et quas assumenda repellat. Accusantium necessitatibus dolore optio qui sequi. Est esse porro voluptatum sed perspiciatis.', '1989-10-05 06:41:49', '1987-10-10 21:53:33');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('45', '45', 'Et necessitatibus iure quis odit dolorem eum. Eum veniam inventore explicabo itaque iusto ipsum. Deserunt aliquid est repellat velit est explicabo nam.', '2018-03-25 20:38:41', '1990-04-24 07:34:37');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('46', '46', 'In et rerum eius id itaque sint. Unde a eos voluptatem dignissimos debitis quo. Veniam tempore animi pariatur reiciendis voluptatem.', '1980-08-12 11:13:34', '1970-11-27 08:10:51');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('47', '47', 'Accusamus a corporis ex soluta placeat voluptas. Est culpa quis incidunt necessitatibus sed sed ipsam et.', '1990-08-18 06:08:07', '1983-01-21 16:09:47');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('48', '48', 'Et nam culpa non natus. Eligendi nostrum ut et ut.\nEligendi earum quia debitis qui adipisci. Enim molestias fuga quisquam est et libero doloribus itaque. Id dolor ex asperiores velit aut ex quia ut.', '2012-07-03 09:34:53', '2003-04-01 18:45:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('49', '49', 'Et fuga quibusdam adipisci repudiandae minus. Exercitationem qui nemo officia placeat vitae.', '1985-09-12 13:31:43', '2002-10-30 11:55:59');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('50', '50', 'Sit rerum et ut voluptas repellat. Sunt quo cupiditate et assumenda.\nEt cum voluptatum sit molestiae voluptas quidem sint. Ad facere ut ea voluptas minus rem aut aspernatur. Adipisci eum magni et.', '1979-06-11 12:02:27', '1974-01-28 22:19:14');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('51', '51', 'Dolores et officia illum occaecati. Quam placeat enim quas quam. Impedit incidunt omnis fugiat provident rerum quia. Ad et molestiae illo culpa.', '1974-04-24 12:11:49', '1997-08-28 12:51:48');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('52', '52', 'Qui harum dolore enim aut. Veritatis maxime minus ut debitis fugit eligendi qui voluptates. Sapiente expedita ut reiciendis ut. Est ut fugit voluptatem sed et optio.', '2002-04-26 07:01:28', '1992-10-18 04:17:29');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('53', '53', 'Consequuntur magnam asperiores non. Facere rem molestiae eligendi eos sed rerum quidem.', '1993-10-12 19:35:14', '2008-12-08 18:52:52');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('54', '54', 'Mollitia odio quidem quia perferendis. Est tenetur earum porro illum sit. Tenetur suscipit aliquid consequatur consequatur beatae. Cumque dolorem perferendis enim.', '2010-07-12 19:42:39', '1985-05-10 09:55:34');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('55', '55', 'Veniam voluptatem quod tempore. Quo possimus eos illum minus enim aliquid praesentium. Temporibus eligendi dolores et odio libero. Cumque aut quia voluptatem. Dolores iste aut voluptas ea delectus.', '2015-02-14 22:38:15', '2016-05-23 18:05:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('56', '56', 'Iure facilis qui et magni quia aliquam. Et alias neque rerum earum. Ipsa sed voluptatem in numquam.', '1997-04-23 08:06:31', '1982-09-17 08:38:12');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('57', '57', 'Corrupti ut aspernatur vel neque assumenda unde labore. Quo quidem ad occaecati ut mollitia. Voluptas veritatis reprehenderit eveniet rem sunt.', '1992-05-12 16:04:09', '2018-11-25 03:50:34');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('58', '58', 'Omnis corrupti necessitatibus voluptatem. Dolorem architecto sint officiis nam et provident illum est. Modi saepe aut adipisci quo ad iure aut.', '1977-06-03 01:21:36', '1996-12-14 23:57:31');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('59', '59', 'Repellendus sunt consequatur reprehenderit corrupti. Non ea quis sit deleniti quia quos sed. Fugiat omnis eos natus ut et velit. Et dignissimos quia id quis sed in provident nostrum.', '2010-12-10 23:17:38', '2013-05-26 19:25:50');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('60', '60', 'Et quidem quas fuga et et voluptas soluta. Voluptas voluptatem ab vel autem quia debitis ut. Occaecati aut eum ex nihil cum. Qui quas ut nostrum atque repellat.', '2008-12-01 00:59:37', '1974-01-31 08:27:31');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('61', '61', 'Dolore sunt ipsa unde. Atque dolorum quasi nobis laboriosam. Reprehenderit consequatur aut explicabo nulla et hic. Dolorem ea non in voluptatem.', '2018-07-21 02:23:31', '1983-09-12 10:18:58');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('62', '62', 'Rerum nesciunt corrupti facilis modi consequatur. Nesciunt est iste amet omnis. Illum quibusdam omnis omnis eum. Dolorem nam consequatur quas.', '1987-07-26 01:32:25', '1978-10-19 00:38:58');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('63', '63', 'Culpa alias aut rem et reiciendis. Explicabo harum molestiae dolores aliquam aliquam. Adipisci quibusdam aut est voluptate harum fugit placeat. Ipsa libero voluptate ut aliquam.', '1983-01-21 02:10:00', '1986-01-15 03:57:17');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('64', '64', 'Aut et dicta inventore omnis commodi. Facere eum vel sed laborum et ea. Omnis et distinctio perspiciatis nihil architecto hic.', '1976-01-15 07:04:27', '1990-01-06 23:52:24');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('65', '65', 'Eum nesciunt repellat sint optio. Iste provident debitis beatae atque quibusdam. Est qui animi ut tempora impedit eveniet vel.', '1997-05-22 09:18:35', '1986-03-04 07:20:16');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('66', '66', 'Tempore omnis dolor unde repudiandae est. Consequuntur non vel consequatur totam ipsa maiores ut. Excepturi quod dolor et est modi laborum. Minima quidem tempore nam vel ipsam.', '1982-12-28 14:04:46', '1997-09-11 21:00:38');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('67', '67', 'Aut doloribus et rem maxime excepturi voluptatem voluptas. At et recusandae distinctio corrupti. Aut repellendus qui ut explicabo impedit. Nostrum cum exercitationem voluptatem mollitia eaque.', '1994-06-04 19:02:32', '1998-06-16 07:11:25');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('68', '68', 'Id repudiandae voluptate nobis totam et at ipsam voluptas. Aspernatur quo distinctio recusandae aliquid. Nisi pariatur quasi qui ducimus facilis inventore est.', '2017-05-25 02:20:56', '2003-09-11 11:00:35');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('69', '69', 'Laudantium quia molestiae quidem vel. Dignissimos deleniti ut adipisci non a. Qui et voluptatem et vel omnis odit.', '2009-03-27 10:38:07', '2015-05-22 01:49:51');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('70', '70', 'Harum omnis blanditiis quaerat nesciunt labore cum. Suscipit et consequatur voluptatem corporis fugit dolore. Debitis aperiam et totam totam.', '1979-08-05 23:47:59', '1987-07-16 04:01:13');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('71', '71', 'Hic veniam expedita voluptatem minima assumenda sit. Molestiae et a sed suscipit. Et assumenda molestiae nemo laboriosam vel.', '2015-07-29 14:33:22', '1998-01-24 18:01:17');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('72', '72', 'Rem aut similique recusandae. Ut nihil optio nam tempore eius ea fugit est. Nemo facere aliquam placeat deserunt illum totam. Omnis aliquid ab esse et et voluptatem.', '2006-06-24 22:09:50', '1999-07-20 07:26:49');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('73', '73', 'Commodi iure odio commodi repellendus nostrum repellendus vel ea. Molestiae vitae ut quos dolorem fugiat minus. Ullam dignissimos iusto beatae.', '2011-06-13 03:13:33', '1989-06-10 09:02:18');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('74', '74', 'Corrupti tenetur consequatur aspernatur et sed. Libero aut sit sed mollitia aspernatur.\nMinus et quia aut aut aut aspernatur. In distinctio deleniti eum repellendus ipsa ipsam.', '1988-02-27 04:26:56', '1995-02-27 08:37:02');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('75', '75', 'Voluptatem occaecati et expedita vero earum amet consequatur asperiores. Quia iusto laudantium est tempore possimus adipisci.', '2018-04-23 22:41:43', '2010-11-07 06:30:50');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('76', '76', 'Eaque expedita eius dolorem quo quae tempore consequuntur. Omnis voluptates amet commodi cumque eaque eos soluta. Dolor ut aut qui assumenda sit molestias. Enim distinctio in sed iusto aliquid.', '1996-05-14 23:14:12', '1999-12-02 16:38:32');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('77', '77', 'Illo fugit temporibus repellat nulla. Eaque voluptates et incidunt qui cumque. Ipsam soluta non sunt rem dolore sint repudiandae. Vel earum amet iusto ex aut eveniet quia.', '2004-01-14 23:43:46', '2012-10-15 16:21:11');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('78', '78', 'Accusantium unde rerum dolores qui officiis voluptatem rerum sed. Sequi natus tempora consequatur. Autem excepturi dolorum velit ut aperiam culpa molestiae.', '2020-09-25 21:30:15', '2006-05-26 19:52:13');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('79', '79', 'Esse aut rerum autem necessitatibus qui ex quibusdam. Dolor corporis soluta recusandae voluptatem velit. Nemo repellendus ipsa ut error minima amet.', '1990-04-05 21:07:51', '1977-02-21 20:56:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('80', '80', 'Eos ut labore eius sit quibusdam id voluptatem. Harum vel sed exercitationem alias voluptas. Ipsam excepturi autem ducimus ea quis natus distinctio. Aliquam consequatur quod vel aut repellat.', '2011-10-03 17:38:44', '1990-06-23 07:44:36');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('81', '81', 'Odit ipsa rerum aut occaecati quo. Omnis atque consequatur voluptates ea.', '2012-03-15 06:17:20', '1997-03-26 16:27:31');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('82', '82', 'Similique corporis perferendis consequatur dolor assumenda. Asperiores laboriosam et facere sed est veniam inventore. Qui distinctio iusto quo.', '1972-05-22 12:39:03', '2000-03-06 14:04:53');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('83', '83', 'Quasi voluptatum quisquam omnis fuga unde ipsa qui. Sed neque distinctio saepe in et accusamus dolores. Ratione libero rerum ut vel quas. Quis possimus et dicta a.', '2014-02-17 16:33:45', '2018-05-04 08:06:28');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('84', '84', 'Odio quisquam odit doloribus optio quasi qui accusantium et. Rem minus qui a voluptatum. Architecto odit et quae qui quia distinctio.', '1976-01-03 23:33:43', '2015-04-22 09:58:32');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('85', '85', 'Optio possimus tenetur vel repellendus consequatur modi illo. Ut esse cumque consequatur enim corporis dignissimos. Iure autem porro ut.', '1986-08-22 20:58:49', '2013-09-30 02:03:47');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('86', '86', 'Sed qui cum inventore libero in aliquam optio. Consequatur earum et fugiat vel totam temporibus magnam.', '1995-03-31 06:53:43', '2012-02-05 09:07:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('87', '87', 'Eos quae quaerat et enim reprehenderit. Fugiat qui ipsam in exercitationem neque debitis ex. Atque aspernatur cupiditate facilis ut debitis amet cupiditate. Ut dignissimos aut qui quibusdam eum.', '1996-07-30 16:06:31', '1985-02-08 20:50:43');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('88', '88', 'Quod eaque molestias deleniti non ut aliquam est. Nam eum ad ea. Id earum laudantium cumque voluptas et quisquam velit. Quo nostrum beatae et doloribus quidem labore.', '1993-12-18 23:09:43', '1979-04-06 15:04:07');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('89', '89', 'Voluptatem officia aut repellat. Cupiditate sequi eos voluptas quae. Omnis expedita tempore quis quam.', '1991-12-12 00:44:41', '2017-04-02 23:41:35');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('90', '90', 'Cum dolorem molestiae qui tempore voluptas. Aut sequi nisi consequatur quos. Hic deleniti perspiciatis rerum tenetur repellendus eos. Sit maiores animi magnam consequatur.', '1998-06-21 07:28:13', '2010-06-23 02:05:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('91', '91', 'Doloremque deleniti ea aperiam exercitationem molestiae omnis iure tempora. Temporibus accusamus explicabo non qui. Voluptatem nulla assumenda corrupti veritatis recusandae totam sed.', '1991-07-17 12:59:54', '1986-07-06 08:47:38');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('92', '92', 'Omnis maxime optio autem voluptatibus est labore deleniti. Aut velit vel rerum nobis. Adipisci maiores recusandae ut autem voluptatem.', '1999-09-20 09:15:23', '1989-04-04 04:56:52');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('93', '93', 'Inventore eius autem aut laudantium consequatur. Harum ullam nulla aperiam inventore velit hic. Officiis enim velit quia qui.', '1992-04-01 23:24:57', '2014-11-16 06:05:54');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('94', '94', 'Nobis et tenetur alias et qui veniam. Consectetur esse repellendus sapiente deserunt amet. Ad odio velit maiores impedit. Libero incidunt odio architecto ducimus.', '1986-11-07 05:21:06', '1979-10-07 16:27:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('95', '95', 'Consequatur aut natus in aut impedit. Voluptatem sint sint voluptates dignissimos doloremque sunt nesciunt. Reprehenderit repudiandae temporibus exercitationem. Ipsa commodi et numquam in.', '2014-03-01 18:22:15', '1995-04-19 04:54:19');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('96', '96', 'Magni sint in minima est tempore. In ratione possimus ea laboriosam pariatur facilis. In voluptatem a qui eos et sed ut minus. Est amet in magnam enim similique officia.', '2020-01-01 12:19:54', '1997-10-11 08:28:28');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('97', '97', 'Vitae rerum ex id porro assumenda iure. Nisi hic aut debitis sit sit quidem sint. Ipsa atque quo excepturi.', '1998-06-05 17:37:39', '1972-08-17 14:03:33');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('98', '98', 'A necessitatibus aut ipsum non libero laboriosam voluptatem. Corrupti quibusdam labore vel vero quia omnis. Fugiat qui consequatur adipisci qui. Eos ut voluptatibus voluptas illo rerum.', '1988-08-24 14:02:48', '2010-04-11 19:31:17');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('99', '99', 'Libero iusto laudantium et provident nesciunt a qui rem. Esse ipsum dolor dolorum. Exercitationem quis totam neque ut laborum consequatur sunt.', '2001-11-09 00:03:18', '1975-05-19 00:21:50');
INSERT INTO `posts` (`id`, `user_id`, `post`, `created_at`, `updated_at`) VALUES ('100', '100', 'Dolorem quidem deleniti eaque autem quos. Voluptate molestiae minus rerum natus autem et qui. Et expedita et aut provident.', '2016-03-17 12:46:08', '1995-12-06 10:37:22');

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('1', 'Brennan', 'Schuppe', 'abernathy.ardella@example.org', '1-298-540-1397x56154', '1997-05-31', 'Donavonland', 'm', '1', '1973-04-22 09:48:17', 'f630f812d4046946bb49c1b9c8112627');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('2', 'Paul', 'Schmeler', 'eliza15@example.org', '1-625-005-3913', '1970-09-14', 'Gloverland', '', '4', '1993-05-23 19:37:47', '56db91157473bbc7ad552d5d3281bcf9');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('3', 'Ashlynn', 'Berge', 'welch.samara@example.com', '487.115.6328x730', '1993-04-19', 'Charlesbury', 'm', '4', '1996-09-25 16:18:40', '7c0136ae1ef02cba050de06f435d01b5');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('4', 'Eliezer', 'Blanda', 'cjohns@example.net', '01411633395', '1970-12-19', 'North Amani', 'm', '1', '1970-11-20 13:52:43', 'c0e76f770948be166d95758087033704');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('5', 'Jeremy', 'Goldner', 'alisa.schamberger@example.com', '1-481-446-9484x53648', '1991-12-06', 'Port Grayson', '', '1', '1972-12-12 11:18:00', 'b9b36ffaf403e77cdb49c4023ebbb0cb');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('6', 'Amiya', 'Sporer', 'judson16@example.org', '+07(4)9333511797', '1980-04-29', 'Port Bernardoside', '', '6', '1981-07-25 13:42:22', 'ea36023a1753e629d86604bc061675f3');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('7', 'America', 'Johnson', 'lula94@example.org', '049-771-9257', '1980-03-13', 'North Loyalchester', '', '2', '2003-11-18 09:19:48', 'bcd3da968e10a0bbad4d781e0c2d49ec');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('8', 'Maybelle', 'Wunsch', 'cweissnat@example.net', '087.843.6567x44013', '1975-07-17', 'Powlowskihaven', '', '1', '2013-05-22 08:08:24', '3af86572d22e02f4e17fe67ffdd8212d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('9', 'Zane', 'Gottlieb', 'nienow.d\'angelo@example.com', '+52(8)6961385659', '1990-11-25', 'New Anissatown', '', '9', '1998-05-26 00:39:40', 'e75d522996792048357f138bf94378e9');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('10', 'Carmel', 'Larkin', 'nmraz@example.net', '773-126-6143x2655', '1990-04-16', 'Everardoton', 'm', '5', '2009-09-27 09:17:38', '30b81bdae20745f92fbe5e514ed48cc2');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('11', 'Vivien', 'Feest', 'erna.spencer@example.org', '039-673-9656x9539', '2010-05-26', 'Zboncakview', 'm', '7', '2000-09-23 09:10:26', '047c344fbd6673d0a7f7402db018d3d6');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('12', 'Erica', 'Kirlin', 'xhettinger@example.net', '021.549.1239x8822', '1977-09-19', 'Wuckertmouth', 'm', '5', '1983-05-30 15:47:51', '744ec1efc47e4c136e710663845f0f33');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('13', 'Jamil', 'Brown', 'lincoln.mayer@example.org', '479-731-5598x20352', '1973-10-31', 'Timmothytown', 'm', '8', '1982-07-07 04:57:46', 'ee585f9cc592596ceb57fc1fb3942f81');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('14', 'Earnestine', 'Mertz', 'rherman@example.com', '1-022-439-6689', '1991-04-27', 'Donniestad', 'm', '8', '2009-11-11 21:04:04', 'd44276ca29c95f73130cf7554b49889a');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('15', 'Ronny', 'Heaney', 'chester96@example.com', '386.452.8012', '2017-12-12', 'Altenwerthfort', '', '0', '1984-08-28 09:26:03', '0c8eeb949cd2d21ee1dec2b46a8bdb51');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('16', 'Gussie', 'Krajcik', 'bjenkins@example.org', '445-320-6929x2265', '1998-12-10', 'North Kay', 'm', '4', '1989-06-14 06:42:02', '004858509123c81ea971a492547602b6');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('17', 'Demetris', 'Reichert', 'schamberger.bennie@example.com', '(413)816-1175x362', '2012-01-19', 'East Germainemouth', 'm', '3', '2010-02-12 11:42:36', 'e4a66cf25d9aedeb8b14402b22280566');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('18', 'Aniya', 'Haag', 'suzanne.legros@example.com', '1-891-714-4434', '1986-11-25', 'Davidborough', 'm', '0', '2001-05-06 11:19:16', 'e8cae8592fb5358420f0262820ba11ea');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('19', 'Kristian', 'Heidenreich', 'ndenesik@example.net', '05331307968', '1993-09-01', 'Jakubowskiton', '', '6', '1990-01-18 18:09:11', 'b9c59da5f6f7026795eaa7788c1d6cda');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('20', 'Easton', 'Gutmann', 'jude.bogisich@example.org', '933.421.8764', '1996-05-21', 'Port Richmond', 'm', '8', '1996-06-21 18:27:38', 'c2b62d6406914814dfee50c4e8255056');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('21', 'Taya', 'Orn', 'batz.liliana@example.net', '1-292-926-6732x7675', '2009-05-03', 'New Ileneview', 'm', '8', '1975-08-31 11:46:14', 'e36923c0e96609abb7f0a3a3d66528d4');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('22', 'Hertha', 'Christiansen', 'christophe.conn@example.org', '1-525-607-7053x50467', '1990-10-30', 'Adanville', '', '2', '1979-04-02 08:54:37', 'd4ddcb64f3627c59089663a2ed3779bd');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('23', 'Renee', 'Skiles', 'esteban.rath@example.com', '450-751-1839x27142', '1981-05-20', 'New Pierre', '', '3', '2014-11-03 07:17:12', 'c7d4871934a27a8be3548b4ce44c9314');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('24', 'Mallie', 'King', 'dorothea.bashirian@example.org', '118.443.2460x5157', '1983-05-28', 'North Adrienne', 'm', '0', '1979-10-24 00:05:55', 'e5b6cc17639ea9dc943780aae3474dbc');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('25', 'Herbert', 'Wisoky', 'justine.collins@example.org', '+60(8)1145751730', '2009-01-16', 'East Martine', 'm', '6', '1991-02-11 09:00:02', 'ce8ef4b41f2b46f8fd1b8376d1179941');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('26', 'Haven', 'Parisian', 'amanda.bosco@example.net', '403-430-6517x4876', '1984-12-16', 'North Jeff', 'm', '7', '1991-01-03 20:38:22', '3d677549d1b3ff463c7f5a60b49aff59');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('27', 'Quincy', 'Moore', 'layla47@example.com', '594.493.0120x78166', '2018-05-15', 'West Mona', 'm', '5', '2004-11-26 05:31:13', 'e087994c074c76f2fa5fbf0806742f73');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('28', 'Grace', 'McCullough', 'turcotte.kobe@example.com', '128.747.2439x99963', '1973-05-05', 'Leoramouth', 'm', '3', '1981-01-29 16:50:19', '3ba644f4858fd50c8718c33520a1a540');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('29', 'Tremayne', 'Boyer', 'urussel@example.com', '985.369.9617x416', '2006-01-15', 'Port Sydnee', 'm', '9', '2002-01-30 23:55:13', '3ff049a5dde59d59e43745cb5e35eb88');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('30', 'Shaylee', 'Gislason', 'dickens.jeffry@example.org', '650-544-8148x481', '2015-01-15', 'Lessiestad', 'm', '6', '2006-08-31 04:00:04', '46f28b765d2ea78dba2f7c26def8ddf7');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('31', 'Wyman', 'Bergnaum', 'lavon91@example.org', '131.062.6452x345', '2018-02-13', 'New Orionstad', 'm', '8', '2019-06-02 04:49:24', 'e1e59b6f45425767fb477c5bbc1c1522');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('32', 'Brionna', 'Schowalter', 'joannie.wolff@example.com', '786.603.0772x4445', '1991-02-04', 'Janaport', 'm', '9', '2011-01-06 02:35:29', '7f42c7a5239885899ee13cb44eaff531');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('33', 'Nedra', 'Dare', 'curt93@example.org', '+49(8)2486399669', '1982-08-24', 'Rutherfordside', '', '6', '1999-12-30 14:37:50', '3e70f87a15390fdca883fa361393a8e9');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('34', 'Vicenta', 'Farrell', 'purdy.amanda@example.net', '(791)596-0735x5117', '1982-07-20', 'Kulaston', '', '5', '1978-03-18 01:16:09', 'caa6e5e6028f62b1b292359c4f33a1f9');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('35', 'Kale', 'Streich', 'jade.daugherty@example.com', '202-509-0749', '1982-04-03', 'Joanaville', 'm', '7', '1992-06-19 06:08:43', 'f4a6ccc060888fdb35d4929f0a9b03ac');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('36', 'Frederic', 'Schulist', 'nmayer@example.net', '1-078-733-5990x5364', '2001-08-25', 'Cronintown', 'm', '8', '1993-01-23 08:03:46', 'ddc015f9755650ffa7f28e1b89d4580c');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('37', 'Soledad', 'Williamson', 'price.christelle@example.net', '566.589.2844x339', '2001-11-01', 'New Alexanderfort', 'm', '0', '1982-03-06 22:54:39', '90dfa02d3d34095797c45ef2ae13a179');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('38', 'Aron', 'Turner', 'christine.walsh@example.org', '723.342.9576x54287', '1978-02-07', 'Gloverberg', '', '8', '1980-02-01 22:46:22', 'ab3302be4977ff522d2956eccc70395c');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('39', 'Orion', 'Swift', 'cornell45@example.org', '186.027.7654', '1986-12-20', 'North Hollis', 'm', '9', '1977-07-18 19:58:14', '968d1646ee26a45384273f2df61037c3');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('40', 'Ernestina', 'Treutel', 'phamill@example.net', '521-604-0309x3431', '2010-06-30', 'West Derrick', 'm', '1', '2002-01-15 04:33:54', 'ce600c94c7112cd1cc239a071f36dbe5');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('41', 'Monty', 'Pagac', 'ytillman@example.org', '1-192-856-1893', '1986-05-22', 'North Mathilde', '', '4', '1987-04-19 07:34:54', 'c33d9a3c3ee3737f84b9298d83ed0c10');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('42', 'Domingo', 'Daugherty', 'ibrahim94@example.net', '989-557-4949', '1970-02-11', 'Lake Mylene', '', '1', '2011-09-07 13:15:35', 'e80842894e5b62ab2ce2d82a40a2a59c');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('43', 'Rosetta', 'Smitham', 'lysanne.sipes@example.org', '04108762287', '1990-11-06', 'Solonburgh', '', '8', '1973-01-09 23:45:20', '44f2f334b878fd6b1c88c91c99a2c8d1');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('44', 'Bernie', 'Cartwright', 'emiliano43@example.com', '584.933.9648x9694', '1990-05-05', 'Port Angieshire', '', '0', '1988-07-10 21:05:03', 'bcc85352148303fa7d2e3a093386b076');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('45', 'Brando', 'Braun', 'zaria.konopelski@example.net', '(815)954-7710x983', '2012-02-20', 'Marielaville', 'm', '3', '2020-07-28 17:15:44', 'b2c804e8c79b03040accaaf30a415d1b');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('46', 'Sincere', 'Halvorson', 'zfay@example.net', '953-669-3778', '1990-10-25', 'Berylmouth', '', '6', '1974-05-02 15:23:34', '86144b3a4805f14cf91b8010e62d72fe');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('47', 'Geoffrey', 'Pacocha', 'jo59@example.org', '263-094-0119x785', '2000-05-11', 'New Octaviafort', 'm', '8', '1988-09-25 10:34:52', '8d787c40c96def4b31958786411041de');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('48', 'Emery', 'Zulauf', 'herminia66@example.com', '208-438-4318x35989', '1992-10-02', 'Port Dimitri', 'm', '1', '1974-11-25 15:50:43', 'b333d737394e1116e93534bf709b3211');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('49', 'Katlynn', 'Witting', 'hickle.shayna@example.org', '(902)773-0542', '2019-05-02', 'West Rico', '', '0', '2000-02-23 16:57:20', 'f8aec73e00931dc0efe7d61c5e4220cd');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('50', 'Filomena', 'Thiel', 'rhett.lubowitz@example.net', '354.365.7681x081', '1984-01-27', 'Kulasland', 'm', '9', '1977-06-26 21:18:57', 'f1cdbf2cf66cbd20bdd0657fbf85faaa');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('51', 'Mara', 'Donnelly', 'ibrahim30@example.net', '+61(3)1694573477', '2017-10-07', 'East Lavada', '', '6', '1997-10-08 19:16:42', '86403ec60488c7015b083a4299c955d3');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('52', 'Eldora', 'Jaskolski', 'boehm.concepcion@example.net', '+01(2)5086899058', '2007-07-19', 'Samarahaven', 'm', '8', '2008-05-18 12:06:28', '088d583dad5d9111e7da365a82843b6d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('53', 'Otis', 'Beatty', 'szemlak@example.net', '(180)089-6340x7581', '1987-01-25', 'East Kaci', '', '2', '2013-05-29 04:42:54', '0730f04aac6ee1bad6587d1c8813235d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('54', 'Sammy', 'Hettinger', 'magali15@example.org', '497-987-3074', '1994-09-20', 'Rowanmouth', 'm', '1', '2001-08-18 13:52:47', '53928fa8cacc75b51704667de036d53e');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('55', 'Vita', 'Zemlak', 'bins.eliseo@example.com', '1-617-343-6937x2395', '1990-10-13', 'Maurinemouth', '', '8', '1998-11-29 14:26:33', 'fc9c2c8d4f9c3bbfa2b94096809cf963');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('56', 'Meggie', 'Effertz', 'dortha09@example.com', '813-864-3685x087', '2011-01-05', 'Port Willie', '', '8', '1982-06-12 16:18:44', '6853d74d90d4540111a1b0bbcc851847');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('57', 'Maxie', 'Hyatt', 'flavie70@example.org', '(311)243-8641x3203', '2005-08-29', 'Lake Arlenefurt', 'm', '7', '1990-03-08 22:03:36', 'f30f5bae217cd71587f472e9433e0f09');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('58', 'Mohammad', 'Marquardt', 'ulices13@example.com', '958-353-9120', '2016-04-09', 'North Odessa', '', '8', '2002-03-12 08:15:27', '168028786457fe8a4b8b552e47c41cb0');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('59', 'Ned', 'Orn', 'nbechtelar@example.net', '1-056-378-4569', '1976-09-24', 'New Kevon', '', '4', '1975-08-15 20:21:58', '64b9e73d7217f64cd743243eb82cabdb');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('60', 'Jada', 'Kshlerin', 'syble.gerlach@example.net', '(540)525-3985x8764', '1987-04-05', 'Justonstad', '', '8', '2018-11-17 22:00:45', '7bf33433826579c35ac96ce4c0e8bc9c');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('61', 'Chaim', 'Auer', 'amir.lockman@example.com', '561-642-9512x207', '2010-08-13', 'Kertzmannshire', 'm', '1', '1981-01-03 13:10:25', 'd565cd48e417c764ef4a0adc5083e23e');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('62', 'Kamille', 'Quigley', 'jonathan.roob@example.org', '466-490-7044x54298', '2007-09-15', 'East Roelfurt', 'm', '3', '1995-10-26 14:47:04', 'fcac5b70318e9a019d8a86469c80de9b');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('63', 'Bernard', 'Metz', 'lew16@example.net', '1-883-530-4187x25625', '2000-06-16', 'Veronicahaven', '', '6', '1977-10-06 07:00:17', 'd8422cb62f2fa6256fa6e293c47629f1');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('64', 'Ellen', 'Hirthe', 'candida69@example.com', '1-989-143-5310x9209', '2017-12-24', 'Lake Peyton', '', '2', '2008-09-28 12:13:35', 'b17f00c76a8c4f64b98c5ed9bbb4afbf');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('65', 'Louisa', 'Brown', 'fheaney@example.org', '(524)439-0691x913', '1994-09-03', 'Joycebury', 'm', '9', '2010-08-30 10:47:06', 'd7f873bd75b0f78d21a8a066c2714b1b');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('66', 'Elton', 'Conroy', 'maudie56@example.com', '05492991744', '1992-01-17', 'New Laron', '', '3', '1988-04-08 16:50:09', '10f4721a59ed37f361267d6f020ff25a');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('67', 'Josie', 'O\'Keefe', 'isac.fay@example.com', '04681362935', '1992-05-04', 'Port Markus', '', '6', '2015-11-05 20:50:06', 'b0ed4f0ebb0f7c6feab949d744398b6d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('68', 'Pierce', 'Reynolds', 'reilly04@example.org', '05856250321', '1975-12-28', 'Port Neal', '', '0', '1980-11-20 15:00:46', '1803fea51a96fc4d3ebc5a84c6ee7fda');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('69', 'Camilla', 'Greenholt', 'dooley.shad@example.net', '308.257.4455', '1978-06-23', 'East Zola', '', '3', '1997-04-10 10:52:58', '613738207feb19aa3c15cdcbd2c2b6dd');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('70', 'Justyn', 'Olson', 'dhagenes@example.com', '615-187-8429x253', '1981-03-11', 'Hackettview', '', '6', '1979-11-12 06:46:44', 'ba2ed4f9dda3a382a9c477f9bc3c5ec5');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('71', 'Fay', 'Leannon', 'sid63@example.com', '508.926.8555', '2016-12-25', 'Boyleport', 'm', '7', '1971-12-01 06:57:21', 'b63aac63f55e66737c4f35aea88f2160');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('72', 'Rhianna', 'Barrows', 'gerhold.khalid@example.org', '220.316.6284x09076', '1981-09-08', 'South Lafayetteborough', 'm', '9', '1984-01-05 04:02:57', 'fc3f03c4109910e65426077408058a06');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('73', 'Eden', 'Breitenberg', 'odell74@example.org', '02143035213', '1991-09-13', 'Simoneshire', 'm', '0', '2019-10-12 15:17:07', 'e85ba6ebbd8c1a5b3d6c26526a1b0ff9');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('74', 'Pattie', 'Miller', 'fwyman@example.com', '716-375-1407x997', '2007-07-23', 'Dachton', '', '6', '1975-02-25 00:13:45', 'e2ef14dc9ef8aea5de28cc2376db8a07');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('75', 'Hassie', 'Kutch', 'koelpin.alysson@example.net', '1-475-688-1147', '1970-12-14', 'North Tayamouth', '', '2', '1972-08-13 16:31:52', '3157f3bacd31b6f1b962e6b30c5d4c5c');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('76', 'Aidan', 'Stokes', 'ohodkiewicz@example.org', '642.855.5183', '2012-11-05', 'Heidenreichville', 'm', '5', '1996-02-21 18:32:59', '5d99e7c46637e9ce50cd288724781236');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('77', 'Landen', 'Yundt', 'jaiden.lebsack@example.net', '522.469.1802x0000', '2009-05-07', 'New Markhaven', '', '4', '2016-08-22 12:35:33', '5419ebb464f76418d791c564ca65d763');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('78', 'Wilfred', 'O\'Connell', 'demetris11@example.org', '767.579.8159', '2012-06-15', 'Lake Chet', 'm', '5', '2005-02-08 10:54:07', '82093d01dc0a0d3774ab407c3a6db420');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('79', 'Ramona', 'Bosco', 'bins.bobby@example.com', '882.772.7199x27253', '2012-03-29', 'North Melvina', '', '2', '1993-09-25 04:55:22', '92c9ee01b5d24af9f73cf21bd087074a');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('80', 'Alexis', 'Johns', 'sanford.jany@example.org', '(056)510-7885', '2003-06-15', 'East Zane', '', '0', '1983-04-23 09:51:50', '4e5056846c61621834caa42cff340177');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('81', 'Gina', 'Barrows', 'pierce86@example.org', '962-751-6409x0929', '1978-05-17', 'East Deonside', '', '3', '1999-09-26 00:20:43', '36c7ce417c1a3450e574793100b9ba40');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('82', 'Aniya', 'Kub', 'eileen19@example.com', '(581)295-9975', '2014-04-04', 'East Gail', '', '2', '1976-03-25 22:17:29', 'c8955ced08a9da6e869c0b5663e2621f');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('83', 'Deshaun', 'Hilll', 'tmcdermott@example.com', '1-654-405-5302x26666', '2002-02-10', 'Lake Giuseppeside', 'm', '8', '1999-10-03 15:12:44', '9c61db11ca8b31e670a8b0e968491770');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('84', 'Erna', 'Bogan', 'zieme.elmo@example.com', '716.400.8005x1056', '2007-11-05', 'South Devanteland', '', '2', '1981-11-21 21:38:56', '52e4f2e4bc064d6e26f56f130f6b19ea');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('85', 'Dejon', 'Wiegand', 'crona.kayley@example.net', '(294)631-6619', '2019-02-15', 'North Jerome', 'm', '3', '1993-04-01 08:33:39', 'db097a3a7b330f083662d6f89d0f2c46');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('86', 'Reuben', 'Frami', 'tgerhold@example.org', '566-080-6709x587', '1976-03-26', 'Port Maureenside', 'm', '7', '1974-04-02 18:51:40', '814770f733b10cbfa90f1bf4695b4ab2');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('87', 'Renee', 'Waters', 'lschuster@example.net', '1-171-895-1442x668', '1976-07-21', 'East Alishashire', '', '7', '2003-10-02 00:50:50', 'd0270040dddaf12ae3f561c34f31459d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('88', 'Bernardo', 'Lehner', 'mandy60@example.net', '1-905-788-9157', '2005-11-13', 'Maymieberg', 'm', '7', '2010-10-01 23:05:24', '107fb4c4b988de7e40e9ad2ac3456348');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('89', 'Ivy', 'Kulas', 'qfritsch@example.com', '212.358.9300x329', '2003-07-31', 'East Burleyton', 'm', '2', '2013-02-08 16:57:13', '8ba949258563bafd2e4e19348cf1b888');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('90', 'Rogelio', 'Wisozk', 'cristian.volkman@example.net', '825-145-8048x9701', '1974-07-26', 'Port Francesca', 'm', '3', '1992-01-28 00:48:42', '2a749fdd4f426ffb731474b03cbc7b76');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('91', 'Chasity', 'Sawayn', 'hspencer@example.org', '1-902-613-0608x9386', '1980-08-19', 'Lake Marianport', '', '7', '1989-04-12 04:53:24', 'deaf55f065f518b7c6cba4b55592b3be');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('92', 'Nathaniel', 'Leffler', 'kara.gulgowski@example.net', '938.517.6550', '1972-11-05', 'Port Flavietown', '', '9', '1976-12-18 15:56:16', 'b5771ab6831f3bb3955a45907ca66662');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('93', 'Audie', 'Rutherford', 'zmarquardt@example.com', '+39(3)7072454345', '1999-08-16', 'North Chanellemouth', '', '9', '2007-05-20 07:07:11', 'bed78449165053387bbde2bce0ede9fa');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('94', 'Guido', 'Treutel', 'lolita.kulas@example.net', '+41(6)3132511129', '1992-08-01', 'Treutelborough', 'm', '4', '2009-04-28 09:25:21', '385f057b9a16c6c71627563ae6731a1f');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('95', 'Theodore', 'Kirlin', 'maggio.cooper@example.net', '(800)122-5765x37923', '1993-10-29', 'Carmeloton', '', '8', '1974-02-15 04:03:28', 'a05265ad011496ed28bd272e2aeb465d');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('96', 'Dewitt', 'Dickens', 'mckenzie.aida@example.org', '+31(5)5913679667', '1994-08-10', 'West Margarettaton', '', '8', '1982-09-30 05:05:03', '851317344caf91fb2377745d9e03c10f');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('97', 'Eunice', 'Hessel', 'tia.tremblay@example.com', '1-381-402-3897', '2009-07-28', 'Lindgrenfort', '', '3', '2020-07-18 12:15:47', '4e5f0a81cb5a81559d5d56b888ce3887');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('98', 'Marian', 'Dibbert', 'erica19@example.com', '755-195-9252', '1970-12-04', 'Sporerfurt', '', '8', '1992-07-02 10:52:47', '4aaee4a6998226272f6561625b67bc63');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('99', 'Devyn', 'Denesik', 'gd\'amore@example.com', '165-920-1948', '1972-12-27', 'Laurynport', 'm', '4', '1974-06-14 00:43:32', 'f50d98272ee34079bcfce0db0b4235a7');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `bday`, `hometown`, `gender`, `photo_id`, `create_at`, `pass`) VALUES ('100', 'Stanton', 'Gislason', 'misael76@example.org', '376-592-7154x333', '1973-01-21', 'Dietrichberg', '', '3', '2005-03-12 06:24:57', '14527ad69daee3b89826edf240f40cb4');

INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('1', '1');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('2', '2');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('3', '3');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('4', '4');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('5', '5');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('6', '6');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('7', '7');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('8', '8');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('9', '9');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('10', '10');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('11', '11');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('12', '12');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('13', '13');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('14', '14');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('15', '15');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('16', '16');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('17', '17');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('18', '18');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('19', '19');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('20', '20');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('21', '21');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('22', '22');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('23', '23');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('24', '24');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('25', '25');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('26', '26');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('27', '27');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('28', '28');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('29', '29');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('30', '30');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('31', '1');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('32', '2');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('33', '3');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('34', '4');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('35', '5');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('36', '6');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('37', '7');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('38', '8');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('39', '9');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('40', '10');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('41', '11');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('42', '12');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('43', '13');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('44', '14');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('45', '15');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('46', '16');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('47', '17');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('48', '18');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('49', '19');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('50', '20');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('51', '21');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('52', '22');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('53', '23');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('54', '24');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('55', '25');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('56', '26');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('57', '27');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('58', '28');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('59', '29');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('60', '30');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('61', '1');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('62', '2');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('63', '3');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('64', '4');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('65', '5');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('66', '6');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('67', '7');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('68', '8');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('69', '9');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('70', '10');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('71', '11');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('72', '12');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('73', '13');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('74', '14');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('75', '15');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('76', '16');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('77', '17');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('78', '18');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('79', '19');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('80', '20');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('81', '21');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('82', '22');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('83', '23');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('84', '24');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('85', '25');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('86', '26');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('87', '27');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('88', '28');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('89', '29');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('90', '30');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('91', '1');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('92', '2');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('93', '3');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('94', '4');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('95', '5');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('96', '6');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('97', '7');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('98', '8');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('99', '9');
INSERT INTO `users_communities` (`user_id`, `communities_id`) VALUES ('100', '10');

set foreign_key_checks = 1;

-- Home work #4

-- CRUD

-- INSERT

INSERT INTO users 
(firstname, lastname, email, phone, gender, bday, hometown, photo_id, pass, create_at) 
VALUES 
('Сергей','Сергеев','qwe@asdf.qw',123123123,'m','1983-03-21','Саратов',NULL,
'fdkjgsdflskdjfgsdfg142356214','2020-09-25 22:09:27.0');

INSERT INTO users 
set
	firstname='Евгений',
	lastname='Грачев',
	email='dcolquita@ucla.edu',
	phone=9744906651,
	gender='m',
	bday='1987-11-26',
	hometown='Омск',
	pass='1487c1cf7c24df739fc97460a2c791a2432df062';

insert into communities (name) 
select name from communities.communities;

insert into users (firstname, lastname, email, phone, bday, hometown, gender, pass)
select firstname, lastname, email, phone, bday, hometown, gender, pass from users.users
order by bday desc limit 10;

-- select

select * from communities; -- выбираем всё

select * from users limit 15; -- выбираем первые 15 записей

select * from users limit 15 offset 15;-- пропускаем первые 15 (offset), выбираем 15 

select * from users limit 5,5; -- select * from users limit 5 offset 5;

select lastname, firstname, phone from users; -- выбираем данные из 3х столбцов

select lastname, firstname, phone from users order by phone asc; -- сортируем по фамилии в алф. порядке asc - возр, desc - убыв.

select hometown, lastname, firstname, phone from users order by hometown desc, lastname asc; -- сортировака по нескольким столбцам с разным направлением сортировки

select 'hello world!'; -- используем для вывода строки

select sqrt(144); -- работают арифметические операторы

select concat(lastname, ' ', firstname) as persons from users;-- склейка строки с пом. ф-ции concat, добавили алиас для столбца в результирующей выборке

select concat(lastname,' ', substring(firstname, 1,1), '. - ', phone) phone_book from users; -- "обрезаем" имя до первого символа

select distinct hometown from users; -- получаем только уникальные строки

select * from users where hometown = 'Donavonland';

select lastname, firstname, hometown from users 
	where hometown = 'Москва' or hometown ='Санкт-Петербург' or hometown ='Donavonland'; -- ограничения where с "или"

select lastname, firstname, hometown, gender from users 
	where hometown = 'Donavonland' or gender = 'm'; -- ограничения where с "или"
	
select lastname, firstname, hometown, gender from users 
	where hometown = 'Donavonland' and gender = 'm';-- ограничения where с "и"
	
select lastname, firstname, hometown from users where hometown in ('Москва', 'Санкт-Петербург', 'Donavonland'); -- in позволяет задавать несколько значений в where 

select lastname, firstname, hometown from users where hometown != 'Москва'; -- город НЕ Москва
select lastname, firstname, hometown from users where hometown <> 'Москва'; -- аналогично предыдущему

select lastname, firstname, bday from users where bday >= '1980-01-01'; -- условие больше или равно

select lastname, firstname, bday from users where bday >= '1980-01-01' and bday <= '1990-01-01';-- выборка между значениями условий

select lastname, firstname, bday from users where bday between '1980-01-01' and '1990-01-01'; -- аналогично предыдущему

select lastname, firstname from users where lastname like 'Sp%'; -- поиск подстроки, начинающейся на "Ки" и содержащей далее 0 или более символов (%)
select lastname, firstname from users where lastname like '%er'; -- поиск подстроки, заканчивающейся на "ко" и содержащей перед этим 0 или более символов или более символов (%)
select lastname, firstname from users where lastname like 'Aue_';
select lastname, firstname from users where lastname like '_____' order by lastname; 

select count(*) from users; -- 112

select count(hometown) from users; -- 112 not null

select count(distinct hometown) from users; -- 110

select hometown, count(*) from users group by hometown; -- группируем по городу и считаем, сколько пользователей в каждом городе (видимо поставил галочку уникальности при генерировании)

select hometown, count(*) from users group by hometown having count(*) > 1; -- выбираем строки, где пользователей в каждом городе  > 1

-- UPDATE
set foreign_key_checks = 0; -- отключили проверку внешних ключей
SET SQL_SAFE_UPDATES = 0; -- удаление записей без указания ключа (лечим 1175 ошибку) 
update l3.users
	set hometown = 'Омск'
where hometown = 'Donavonland';

-- DELETE
-- fill communities
insert into communities (name) 
select name from communities.communities;

delete from communities where name = 'Японский язык';
delete from communities where id between 20 and 30;
delete from communities;

-- TRUCATE
truncate table communities;
set foreign_key_checks = 1; -- включить проверку внешних ключей
SET SQL_SAFE_UPDATES = 1;

-- ДЗ п.1
-- 
-- 1) с помощью alter поставить в табл. friends_reqiests default status requested
alter table friend_requests modify `status` enum('requested', 'approved', 'unfriended', 'declinde') default 'requested';

-- 2) с помощью alter поставить в табл. переименова create_at в created_at
alter table users change column create_at created_at datetime default now();

-- п2. заполнить табл. likes данными - done


