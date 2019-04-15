#!/bin/bash

set -e

mysql -uroot -h mysql -e '
CREATE DATABASE IF NOT EXISTS `test`;

CREATE TABLE IF NOT EXISTS `test`.`users` (
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

TRUNCATE `test`.`users`;
'

embulk run -b bundle config.yml

mysql -uroot -h mysql -e '
SELECT * FROM `test`.`users` WHERE `name` LIKE "00_";
'
