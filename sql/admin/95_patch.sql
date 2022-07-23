DROP TABLE IF EXISTS `visit_history_initial`;
ALTER TABLE visit_history RENAME visit_history_initial;

CREATE TABLE `visit_history` (
                                 `player_id` VARCHAR(255) NOT NULL,
                                 `tenant_id` BIGINT UNSIGNED NOT NULL,
                                 `competition_id` VARCHAR(255) NOT NULL,
                                 `created_at` BIGINT NOT NULL,
                                 PRIMARY KEY (`tenant_id`, `competition_id`, `player_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

INSERT INTO visit_history
(`player_id`, `tenant_id`, `competition_id`, `created_at`)
SELECT
    player_id, tenant_id, competition_id, min(created_at)
FROM
    visit_history_initial
GROUP BY player_id, tenant_id, competition_id;
