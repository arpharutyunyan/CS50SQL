SELECT "username" FROM "users"
JOIN "messages" ON "users"."id"="messages"."to_user_id"
GROUP BY "to_user_id"
ORDER BY count("to_user_id") DESC, "users"."username"
LIMIT 1;

