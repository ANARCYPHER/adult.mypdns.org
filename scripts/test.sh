#!/usr/bin/env bash
# **********************
# Run PyFunceble Testing
# **********************
# Created by: @spirillen
# Copyright: My Privacy DNS (https://www.mypdns.org/wiki/License)

# ****************************************************************
# This test script uses PyFunceble by @funilrys aka Nissar Chababy
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# **********************
# Setting date variables
# **********************
#printf "\nSetting Variables\n"
source "${TRAVIS_BUILD_DIR}/scripts/variables.sh"

# ******************
# Database functions
# ******************

#MySqlImport
#printf "\nMySql import...\n"
#	sudo mariadb -u root -h ${DB_HOST} -e "CREATE DATABASE pyfunceble DEFAULT CHARACTER SET utf8mb4 COLLATE "${DB_CHARSET}";"
#	sudo mariadb -u root -h ${DB_HOST} -e "CREATE USER 'root'@'%' IDENTIFIED BY ''"
#	sudo mariadb -u root -h ${DB_HOST} -e "CREATE USER "'"${DB_USERNAME}"'"@'localhost' IDENTIFIED BY "'"${DB_PASSWORD}"'";"
#	sudo mariadb -u root -h ${DB_HOST} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO "'"${DB_USERNAME}"'"@'localhost';"
#	if [ -f "${HOME}/db/pyfunceble.sql" ]
#	then
#		mariadb --user="${DB_USERNAME}" --password="${DB_PASSWORD}" ${DB_NAME} < "${HOME}/db/pyfunceble.sql"
#	fi
#printf "\nMySql Import DONE\n"

# ***************
# Import via AXFR
# ***************
printf "\nImporting RPZ database for adult.mypdns.cloud\n"

ImportRPZ () {
	mysql -u"${imp_user}" -p"${imp_pw}" -h"${imp_host}" -B -N -e "SELECT TRIM(TRAILING '.adult.mypdns.cloud' FROM name) AS name FROM pdns.records WHERE \`type\` = 'CNAME' AND domain_id = '61' AND content = '.' LIMIT 10000000;" > "${testfile}"
}
ImportRPZ

printf "\nWe have to test $(wc -l < "${testfile}") DNS records.

	You can read more about how to use this privacy enhanced
	DNS firewall driven by Response Policy Zones at
	https://www.mypdns.org/wiki/RpzList\n"

#ImportWhiteList () {
	#printf "\nImporting whitelist\n"
	#truncate -s 0 "${whitelist}"
	#wget -qO "${whitelist}" 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/whitelist/domain.list'
	#wget -qO- 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/whitelist/wildcard.list' >> "${whitelist}"
#}
#ImportWhiteList

#WhiteListing () {
    #if [[ "$(git log -1 | tail -1 | xargs)" =~ "ci skip" ]]
        #then
			#printf "\nRunning whitelist\n"
            #hash uhb_whitelist
            #uhb_whitelist -f "${testfile}" -o "${testfile}"
	#else
		#printf "\nSkipping whitelist\n"
    #fi
#}
#WhiteListing

#exit ${?}

#bash "${script_dir}/pyfunceble.sh"

touch "${TRAVIS_BUILD_DIR}/run_it"
truncate -s 0 "${TRAVIS_BUILD_DIR}/run_it"
echo "date +'%s'" > "${TRAVIS_BUILD_DIR}/run_it"


exit ${?}
