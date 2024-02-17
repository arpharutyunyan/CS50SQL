SELECT players.first_name, players.last_name,
(salaries.salary / performances.H) AS dollars_per_hit FROM players
JOIN salaries ON salaries.player_id=players.id
JOIN performances ON performances.player_id=players.id
WHERE salaries.year=2001 AND performances.year=2001
AND performances.H!=0
ORDER BY dollars_per_hit, players.first_name, players.last_name
LIMIT 10;

