ステップ３

以下、1〜6までのデータを抽出するためのクエリを示します。

1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください。

SELECT
    e.title AS episode_title, ev.view_count 
FROM
    episodes AS e 
INNER JOIN
    episode_views AS ev 
        ON e.id = ev.episode_id
ORDER BY
    e.title, ev.view_count DESC
limit 3;


2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。
エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください。

SELECT
    p.title,s.season_number,e.episode_number,e.title AS episode_title,ev.view_count
FROM
    programs AS p
INNER JOIN
    seasons AS s ON p.id = s.program_id
INNER JOIN
    episodes AS e ON e.id = s.id
INNER JOIN
    episode_views AS ev ON ev.episode_id = e.id
ORDER BY
    ev.view_count DESC
limit 3;

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。
本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。
なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします。

SELECT
    c.name AS channel_name,
    cp.start_time,
    cp.end_time,
    s.season_number,
    e.episode_number,
    e.title AS episode_title,
    e.detail AS episode_detail
FROM 
    channel_programs AS cp
INNER JOIN 
    channels AS c ON cp.channel_id = c.id
INNER JOIN 
    programs AS p ON cp.program_id = p.id
INNER JOIN 
    seasons AS s ON p.id = s.program_id
INNER JOIN 
    episodes AS e ON s.id = e.season_id
WHERE
    CONVERT_TZ(cp.start_time, '+0:00', '+9:00') BETWEEN CONVERT_TZ(NOW(), '+0:00', '+9:00') AND DATE_ADD(CONVERT_TZ(NOW(), '+0:00', '+9:00'), INTERVAL 1 DAY)
ORDER BY
    cp.start_time;
    
4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。
ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください。

SELECT
    cp.start_time,
    cp.end_time,
    s.season_number,
    e.episode_number,
    e.title AS episode_title,
    e.detail AS episode_detail
FROM
    channel_programs AS cp
INNER JOIN
    programs AS p ON cp.program_id = p.id
INNER JOIN
    seasons AS s ON p.id = s.program_id
INNER JOIN
    episodes AS e ON s.id = e.season_id
WHERE
    CONVERT_TZ(cp.start_time, '+0:00', '+9:00') BETWEEN CONVERT_TZ(NOW(), '+0:00', '+9:00') AND DATE_ADD(CONVERT_TZ(NOW(), '+0:00', '+9:00'), INTERVAL 1 WEEK)
ORDER BY
    cp.start_time;
    
5. 直近一週間で最も見られた番組が知りたいです。
直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください。

SELECT p.title, SUM(ev.view_count) AS total_view_count
FROM programs p
JOIN seasons s ON p.id = s.program_id
JOIN episodes e ON s.id = e.season_id
JOIN episode_views ev ON e.id = ev.episode_id
WHERE DATE(ev.viewed_at) BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 WEEK) AND CURDATE()
GROUP BY p.id
ORDER BY total_view_count DESC
LIMIT 2;

6. ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。
ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

SELECT g.name AS genre_name, p.title AS program_title, AVG(ev.view_count) AS average_view_count
FROM genres g
JOIN program_genre pg ON g.id = pg.genre_id
JOIN programs p ON pg.program_id = p.id
JOIN seasons s ON p.id = s.program_id
JOIN episodes e ON s.id = e.season_id
JOIN episode_views ev ON e.id = ev.episode_id
GROUP BY g.id, p.id
HAVING AVG(ev.view_count) > 0
ORDER BY average_view_count DESC;
