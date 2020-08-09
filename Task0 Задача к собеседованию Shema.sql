-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--


--
-- Table structure for table `users`
--
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `objecttype`
--
-- Таблица тивов сущностей, которые можно лайкать. Со временем можно добавлять новые виды сущностей 
-- Содержит 3 значения: (1,users), (2,photos), (3,comments)
CREATE TABLE `objecttype` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `photos`
--
-- id_user - id владельца фотографии
CREATE TABLE `photos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user_photo_idx` (`id_user`),
  CONSTRAINT `id_user_photo` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 
-- Table structure for table `comments`
--
-- id_photo - id фото, к которой написан комментарий
-- id_user  - id пользователя, который поставил комментарий
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL,
  `id_photo` int NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_photo_idx` (`id_photo`),
  KEY `is_user_comment_idx` (`id_user`),
  CONSTRAINT `id_photo` FOREIGN KEY (`id_photo`) REFERENCES `photos` (`id`),
  CONSTRAINT `is_user_comment` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `likes`
--
-- id_user - id пользователя, который поставил лайк
-- id_objecttype - принимает 3 значения {1(users), 2(photos), 3(comments)}
-- id_object     - id из таблиц users, photos, comments
-- UNIQUE KEY `id_user_objecttype_object`, гарантирует что пользовательне не сможет лайкнуть одну сущность дважды
-- KEY `objecttype_object - индекс для ускорения поиска в запросах по связке `id_objecttype`,`id_object`

CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_objecttype` int NOT NULL,
  `id_object` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_user_objecttype_object` (`id_user`,`id_objecttype`,`id_object`),
  KEY `id_user_idx` (`id_user`),
  KEY `id_objecttype_idx` (`id_objecttype`),
  KEY `objecttype_object` (`id_objecttype`,`id_object`),
  CONSTRAINT `id_objecttype` FOREIGN KEY (`id_objecttype`) REFERENCES `objecttype` (`id`),
  CONSTRAINT `id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dump completed on 2020-08-08 20:52:16
