テーブル設計
### **テーブル：channels**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | int |  | PRIMARY |  | YES |
| name | varchar(100) |  |  |  |  |

### **テーブル：programs**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | int |  | PRIMARY |  | YES |
| title | varchar(100) |  |  |  |  |
| detail | text | YES |  |  |  |

### **テーブル：genres**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | int |  | PRIMARY |  | YES |
| name | varchar(50) |  |  |  |  |

### **テーブル：program_genre**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| program_id | int |  | INDEX |  |  |
| genre_id | int |  | INDEX |  |  |

### **テーブル：seasons**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | int |  | PRIMARY |  | YES |
| program_id | int |  | INDEX |  |  |
| season_number | int | YES |  |  |  |

### **テーブル：episodes**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| id | int |  | PRIMARY |  | YES |
| season_id | int | YES | INDEX |  |  |
| episode_number | int | YES |  |  |  |
| title | varchar(100) |  |  |  |  |
| detail | text | YES |  |  |  |
| duration | int | YES |  |  |  |
| release_date | date | YES |  |  |  |

### **テーブル：channel_programs**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| channel_id | int |  | INDEX |  |  |
| program_id | int |  | INDEX |  |  |
| start_time | datetime |  |  |  |  |
| end_time | datetime |  |  |  |  |

### **テーブル：episode_views**

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT |
| --- | --- | --- | --- | --- | --- |
| episode_id | int |  | INDEX |  |  |
| channel_id | int |  | INDEX |  |  |
| view_count | int |  |  | 0 |  |
| viewed_at | DATETIME | YES |  | NULL |  |
| view_count | int |  |  | 0 |  |


ER図
https://docs.google.com/presentation/d/1gIljMatLqp6MtdErnHtPLWYRvENuhtzdkPQIq6Mu4mE/edit#slide=id.p
