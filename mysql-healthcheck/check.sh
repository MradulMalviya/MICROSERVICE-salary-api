#!/bin/bash

MYSQL_USERNAME=${MYSQL_USERNAME:-"root"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"password"}
MYSQL_HOST=${MYSQL_HOST:-"empms-db"}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_DATABASE=${MYSQL_DATABASE:-"attendancedb"}
SLEEP_INTERVAL=${SLEEP_INTERVAL:-10}
MAX_RETRIES=${MAX_RETRIES:-10}

retries=0

while [ $retries -lt $MAX_RETRIES ]
do
    if ! mysql -h ${MYSQL_HOST} -u ${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -e "use ${MYSQL_DATABASE}"; then
        echo "Attempt $((retries + 1)): Waiting for ${MYSQL_DATABASE} to be available"
        sleep ${SLEEP_INTERVAL}
        retries=$((retries + 1))
    else
        echo "${MYSQL_DATABASE} is available."
        exit 0
    fi
done

echo "Error: ${MYSQL_DATABASE} is not available after $MAX_RETRIES attempts."
exit 1
