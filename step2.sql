ステップ２ データベースとテーブルの作成

データベースとテーブルの作成から始めます。この手順ではMySQLを使用しますが、他のデータベース管理システムを使用する場合は、適宜コマンドを置き換えてください。

1. MySQLを起動(mysql -u root -p)、パスワード入力後、新しいデータベースを作成します。

    CREATE DATABASE tv_programs;

2. 新しく作成したデータベースを選択します。

    USE tv_programs;

3. 次に、ステップ1で設計したテーブルを作成します。各テーブルの作成には以下のコマンドを使用します。
    
    -- channelsテーブルの作成
    CREATE TABLE channels (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL
    );
    
    -- programsテーブルの作成
    CREATE TABLE programs (
        id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(100) NOT NULL,
        detail TEXT
    );
    
    -- genresテーブルの作成
    CREATE TABLE genres (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL
    );
    
    -- program_genreテーブルの作成
    CREATE TABLE program_genre (
        program_id INT,
        genre_id INT,
        FOREIGN KEY (program_id) REFERENCES programs(id),
        FOREIGN KEY (genre_id) REFERENCES genres(id)
    );
    
    -- seasonsテーブルの作成
    CREATE TABLE seasons (
        id INT PRIMARY KEY AUTO_INCREMENT,
        program_id INT,
        season_number INT,
        FOREIGN KEY (program_id) REFERENCES programs(id)
    );
    
    -- episodesテーブルの作成
    CREATE TABLE episodes (
        id INT PRIMARY KEY AUTO_INCREMENT,
        season_id INT,
        episode_number INT,
        title VARCHAR(100),
        detail TEXT,
        duration INT,
        release_date DATE,
        FOREIGN KEY (season_id) REFERENCES seasons(id)
    );
    
    -- channel_programsテーブルの作成
    CREATE TABLE channel_programs (
        channel_id INT,
        program_id INT,
        start_time DATETIME,
        end_time DATETIME,
        FOREIGN KEY (channel_id) REFERENCES channels(id),
        FOREIGN KEY (program_id) REFERENCES programs(id)
    );
    
    -- episode_viewsテーブルの作成
    CREATE TABLE episode_views (
        episode_id INT,
        channel_id INT,
        view_count INT DEFAULT 0,
        viewed_at DATETIME,
        FOREIGN KEY (episode_id) REFERENCES episodes(id),
        FOREIGN KEY (channel_id) REFERENCES channels(id)
    );
    
4.サンプルデータの挿入を行います。以下のコマンドを実行してください。
    
    -- channelsテーブルのサンプルデータ
    INSERT INTO channels (name) VALUES
    ('チャンネルA'),
    ('チャンネルB'),
    ('チャンネルC'),
    ('ドラマチャンネル');
    
    -- programsテーブルのサンプルデータ
    INSERT INTO programs (title, detail) VALUES
    ('番組A', '番組Aの詳細情報'),
    ('番組B', '番組Bの詳細情報'),
    ('番組C', '番組Cの詳細情報');
    
    -- genresテーブルのサンプルデータ
    INSERT INTO genres (name) VALUES
    ('ドラマ'),
    ('バラエティ'),
    ('アニメ');
    
    -- program_genreテーブルのサンプルデータ
    INSERT INTO program_genre (program_id, genre_id) VALUES
    (1, 1), -- 番組Aはドラマジャンル
    (2, 2), -- 番組Bはバラエティジャンル
    (3, 3); -- 番組Cはアニメジャンル
    
    -- seasonsテーブルのサンプルデータ
    INSERT INTO seasons (program_id, season_number) VALUES
    (1, 1), -- 番組Aのシーズン1
    (2, 1), -- 番組Bのシーズン1
    (2, 2), -- 番組Bのシーズン2
    (3, 1); -- 番組Cのシーズン1
    
    -- episodesテーブルのサンプルデータ
    INSERT INTO episodes (season_id, episode_number, title, detail, duration, release_date) VALUES
    (1, 1, 'エピソード1', 'エピソード1の詳細情報', 30, '2023-05-20'),
    (1, 2, 'エピソード2', 'エピソード2の詳細情報', 30, '2023-05-21'),
    (2, 1, 'エピソード1', 'エピソード1の詳細情報', 30, '2023-05-20'),
    (2, 2, 'エピソード2', 'エピソード2の詳細情報', 30, '2023-05-21'),
    (3, 1, 'エピソード1', 'エピソード1の詳細情報', 30, '2023-05-20');
    
    -- channel_programsテーブルのサンプルデータ
    INSERT INTO channel_programs (channel_id, program_id, start_time, end_time) VALUES
    (1, 1, '2023-05-21 19:00:00', '2023-05-21 20:00:00'), 
    (2, 2, '2023-05-21 20:00:00', '2023-05-21 21:00:00'), 
    (3, 3, '2023-05-21 21:00:00', '2023-05-21 22:00:00'), 
    (4, 1, '2023-05-21 19:30:00', '2023-05-21 20:30:00'); 
    
    -- episode_viewsテーブルのサンプルデータ
    INSERT INTO episode_views (episode_id, channel_id, view_count, viewed_at) VALUES
    (1, 1, 100, '2023-05-21 19:30:00'), 
    (2, 2, 200, '2023-05-21 20:30:00'),  
    (3, 3, 150, '2023-05-21 21:30:00'); 
