# embulk-output-jdbc-issue-241

This repository includes files to reproduce https://github.com/embulk/embulk-output-jdbc/issues/241.
CSV files are created by the following command:

```
for i in {000..007}; do shuf -i 1-1000 -n 1000 > csv/$i.csv; echo $i >> csv/$i.csv; done
```

## Steps to reproduce

```
git clone https://github.com/abicky/embulk-output-jdbc-issue-241.git
cd embulk-output-jdbc-issue-241
docker-compose up
```

## Expected Behavior

``SELECT * FROM `test`.`users` WHERE `name` LIKE "00_";`` outputs a text like below:

```
name
000
001
002
003
004
005
006
007
```

## Actual Behavior

``SELECT * FROM `test`.`users` WHERE `name` LIKE "00_";`` outputs a text like below:

```
name
001
002
003
006
007
```

## Example Log

```
-- snip --
embulk_1  | 2019-04-15 05:48:19.104 +0000 [INFO] (0020:task-0005): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.107 +0000 [INFO] (0019:task-0004): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.108 +0000 [INFO] (0021:task-0006): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.108 +0000 [INFO] (0022:task-0007): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.108 +0000 [INFO] (0018:task-0003): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.109 +0000 [INFO] (0015:task-0000): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.118 +0000 [INFO] (0016:task-0001): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.126 +0000 [INFO] (0017:task-0002): Prepared SQL: INSERT INTO `users` (`name`) VALUES (?) ON DUPLICATE KEY UPDATE `name` = VALUES(`name`)
embulk_1  | 2019-04-15 05:48:19.505 +0000 [INFO] (0022:task-0007): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.540 +0000 [INFO] (0018:task-0003): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.545 +0000 [INFO] (0021:task-0006): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.545 +0000 [INFO] (0019:task-0004): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.549 +0000 [INFO] (0017:task-0002): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.550 +0000 [INFO] (0016:task-0001): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.551 +0000 [INFO] (0020:task-0005): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.567 +0000 [WARN] (0020:task-0005): Operation failed (1213:40001), retrying 1/1 after 1 seconds. Message: Deadlock found when trying to get lock; try restarting transaction
embulk_1  | 2019-04-15 05:48:19.568 +0000 [INFO] (0022:task-0007): > 0.06 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:19.570 +0000 [INFO] (0017:task-0002): > 0.02 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:19.570 +0000 [INFO] (0016:task-0001): > 0.02 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:19.572 +0000 [INFO] (0015:task-0000): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:19.586 +0000 [WARN] (0021:task-0006): Operation failed (1213:40001), retrying 1/1 after 1 seconds. Message: Deadlock found when trying to get lock; try restarting transaction
embulk_1  | 2019-04-15 05:48:19.587 +0000 [WARN] (0015:task-0000): Operation failed (1213:40001), retrying 1/1 after 1 seconds. Message: Deadlock found when trying to get lock; try restarting transaction
embulk_1  | 2019-04-15 05:48:19.592 +0000 [INFO] (0018:task-0003): > 0.05 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:19.592 +0000 [INFO] (0019:task-0004): > 0.05 seconds (loaded 1,001 rows in total)
mysql_1   | 2019-04-15T05:48:19.596374Z 2 [Note] Got timeout reading communication packets
embulk_1  | 2019-04-15 05:48:20.568 +0000 [INFO] (0020:task-0005): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:20.571 +0000 [INFO] (0020:task-0005): > 0.00 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:20.587 +0000 [INFO] (0021:task-0006): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:20.588 +0000 [INFO] (0015:task-0000): Loading 1,001 rows
embulk_1  | 2019-04-15 05:48:20.589 +0000 [INFO] (0021:task-0006): > 0.00 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:20.590 +0000 [INFO] (0015:task-0000): > 0.00 seconds (loaded 1,001 rows in total)
embulk_1  | 2019-04-15 05:48:20.591 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.591 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.592 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.592 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.592 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.593 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.593 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.594 +0000 [INFO] (0001:transaction): {done:  8 / 8, running: 0}
embulk_1  | 2019-04-15 05:48:20.604 +0000 [INFO] (main): Committed.
embulk_1  | 2019-04-15 05:48:20.604 +0000 [INFO] (main): Next config diff: {"in":{"last_path":"./csv/007.csv"},"out":{}}
embulk_1  | name
embulk_1  | 001
embulk_1  | 002
embulk_1  | 003
embulk_1  | 006
embulk_1  | 007
embulk_1  | 2019/04/15 05:48:20 Command finished successfully.
```

## Why are some recoreds not inserted?

`com.mysql.jdbc.PreparedStatement#executeBatchInternal` always clear its `batchedArgs`, so `batchedArgs` is empty in second try.

cf. https://github.com/mysql/mysql-connector-j/blob/5.1.44/src/com/mysql/jdbc/PreparedStatement.java#L1263-L1267
