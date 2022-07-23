# DROP TABLE IF EXISTS `player_score_initial`;
# ALTER TABLE player_score RENAME player_score_initial;
# 
# DROP TABLE IF EXISTS player_score;
# CREATE TABLE IF NOT EXISTS player_score (
#     tenant_id BIGINT NOT NULL,
#     player_id VARCHAR(255) NOT NULL,
#     competition_id VARCHAR(255) NOT NULL,
#     score BIGINT NOT NULL,
#     created_at BIGINT NOT NULL,
#     rn INT,
#     PRIMARY KEY (tenant_id, competition_id, player_id, rn)
# );
# 
# INSERT INTO player_score
# SELECT
#    tenant_id, player_id, competition_id, score, created_at,
#    row_number() OVER (PARTITION BY player_id, tenant_id, competition_id ORDER BY player_score_initial.row_num DESC) as rn
# FROM
#     player_score_initial;
# 
# ALTER TABLE player_score RENAME player_score2;

CREATE TABLE IF NOT EXISTS player_score (
    tenant_id BIGINT NOT NULL,
    player_id VARCHAR(255) NOT NULL,
    competition_id VARCHAR(255) NOT NULL,
    score BIGINT NOT NULL,
    created_at BIGINT NOT NULL,
    PRIMARY KEY (tenant_id, competition_id, player_id)
);

INSERT INTO player_score
SELECT
   tenant_id, player_id, competition_id, score, created_at
FROM
player_score2
WHERE rn = 1;
