#!/bin/bash

[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }

cd $(dirname $0)

echo "CREATE TABLE IF NOT EXISTS history \
    ENGINE=InnoDB \
    DEFAULT CHARSET=utf8mb4 \
    SELECT * FROM passwords WHERE 1=2;" | mysql --defaults-extra-file=mysql.conf myssh

echo "BEGIN; \
    INSERT INTO history \
        SELECT * FROM passwords \
        WHERE time < DATE_SUB(CURDATE(), INTERVAL 7 DAY);
    DELETE FROM passwords \
        WHERE time < DATE_SUB(CURDATE(), INTERVAL 7 DAY);
    COMMIT;" | mysql --defaults-extra-file=mysql.conf myssh
