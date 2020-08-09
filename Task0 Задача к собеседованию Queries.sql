
-- Task1
-- Запрос, который выведет информацию:
--  id пользователя;
--  имя;
--  лайков получено;
--  лайков поставлено;
--  взаимные лайки.


    SELECT 
        `users`.`id` AS `id`,
        `users`.`name` AS `name`,
        `l1`.`likessend` AS `likessend`,
        `l2`.`likesgot` AS `likesgot`,
        `l5`.`mutuallikes` AS `mutuallikes`
    FROM
        (((`users`
        LEFT JOIN (SELECT 
            `likes`.`id_user` AS `id_user`,
                COUNT(`likes`.`id_object`) AS `likessend`
        FROM
            `likes`
        WHERE
            (`likes`.`id_objecttype` = 1)
        GROUP BY `likes`.`id_user`) `l1` ON ((`users`.`id` = `l1`.`id_user`)))
        LEFT JOIN (SELECT 
            `likes`.`id_object` AS `id_object`,
                COUNT(`likes`.`id_user`) AS `likesgot`
        FROM
            `likes`
        WHERE
            (`likes`.`id_objecttype` = 1)
        GROUP BY `likes`.`id_object`) `l2` ON ((`users`.`id` = `l2`.`id_object`)))
        LEFT JOIN (SELECT 
            `l3`.`id_user` AS `id_user`,
                COUNT(`l4`.`id_user`) AS `mutuallikes`
        FROM
            ((SELECT 
            `likes`.`id_user` AS `id_user`,
                `likes`.`id_object` AS `id_object`
        FROM
            `likes`
        WHERE
            (`likes`.`id_objecttype` = 1)) `l3`
        JOIN (SELECT 
            `likes`.`id_object` AS `id_object`,
                `likes`.`id_user` AS `id_user`
        FROM
            `likes`
        WHERE
            (`likes`.`id_objecttype` = 1)) `l4` ON (((`l3`.`id_object` = `l4`.`id_user`)
            AND (`l3`.`id_user` = `l4`.`id_object`))))
        GROUP BY `l3`.`id_user`) `l5` ON ((`users`.`id` = `l5`.`id_user`)))
		;
		
-- Task2
-- Запрос, который выводит список всех пользователей, которые поставили лайк пользователям A и B , но при этом не поставили лайк пользователю C.
--
SELECT 
        `users`.`id` AS `id`, `users`.`name` AS `name`
    FROM
        `users`
    WHERE
        (`users`.`id` IN (SELECT 
                `us1`.`id_user`
            FROM
                (`likes` `us1`
                JOIN (SELECT 
                    `likes`.`id_user` AS `id_user`
                FROM
                    `likes`
                WHERE
                    ((`likes`.`id_objecttype` = 1)
                        AND (`likes`.`id_object` = ID_USER_B()))) `us2` ON ((`us1`.`id_user` = `us2`.`id_user`)))
            WHERE
                ((`us1`.`id_objecttype` = 1)
                    AND (`us1`.`id_object` = ID_USER_A())))
            AND `users`.`id` IN (SELECT 
                `likes`.`id_user`
            FROM
                `likes`
            WHERE
                ((`likes`.`id_objecttype` = 1)
                    AND (`likes`.`id_object` = ID_USER_C())))
            IS FALSE)
;

-- Task3
-- Запрос, который выводит список всех пользователей, поставивших лайки определенной сущнсти
--
 SELECT 
        `users`.`id` AS `id`, `users`.`name` AS `name`
    FROM
        `users`
    WHERE
        `users`.`id` IN (SELECT 
                `likes`.`id_user`
            FROM
                `likes`
            WHERE
                ((`likes`.`id_objecttype` = ID_OBJECTTYPE())
                    AND (`likes`.`id_object` = ID_OBJECT())))
;