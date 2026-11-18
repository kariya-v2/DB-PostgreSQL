START TRANSACTION;

-- 日時の出力形式を ISO にそろえる
SET
  LOCAL DateStyle TO 'ISO, YMD';

-- 確認用の一時テーブルに日時を1回だけ登録する
CREATE TEMP TABLE timestamptz_display_check (registered_at TIMESTAMPTZ NOT NULL);

INSERT INTO
  timestamptz_display_check (registered_at)
VALUES
  (TIMESTAMPTZ '2026-11-18 09:00:00+09');

-- UTC で表示する (期待値: 2026-11-18 00:00:00+00)
SET
  LOCAL TIME ZONE 'UTC';

SELECT
  CURRENT_SETTING('TimeZone') AS time_zone,
  registered_at
FROM
  timestamptz_display_check;

-- 同じ値を日本標準時で表示する (期待値: 2026-11-18 09:00:00+09)
SET
  LOCAL TIME ZONE 'Asia/Tokyo';

SELECT
  CURRENT_SETTING('TimeZone') AS time_zone,
  registered_at
FROM
  timestamptz_display_check;

-- 一時テーブルの作成とタイムゾーンの設定を取り消す
ROLLBACK;
