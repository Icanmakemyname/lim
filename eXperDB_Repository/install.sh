#!/bin/sh
#-------------------------------------------------------------------------------
#
# Script used to install eXperDB monitoring Repository database for postgresql
#
#-------------------------------------------------------------------------------
DB_ENCODING="UTF8"
DB_SCHEMA="pgmon"
DB_NAME="experdb"
DB_OWNER="pgmon"
DB_OWNER_PASSWORD="pgmon"
LOCAL_HOST=" -h localhost"
DB_PASSWORD=""
OWNER_PASSWORD=""
CONN_DB_NAME=""
ORG_DB_HOST=""
ORG_DB_PORT=""
AGENT_HOST=""
AGENT_PORT="5960"
DEBUG=0
AUTORUN=0
REPOPATH=eXperDB_Repository
REPOGEN_FILE=$REPOPATH/pgmon_repository.sh
REPOCREATE_FILE=$REPOPATH/pgmon_repository.sql
LICENSE_FILE=license.dat
LICENSE_STR=

MANAGERPATH=eXperDBMA_MANAGER
MANAGERCONFIG=$MANAGERPATH/config
MANAGERSOCK=$MANAGERCONFIG/SocketListenerInfo.config
MANAGERDBCONF=$MANAGERCONFIG/MyBatisConfig.xml
MANAGERBIN=$MANAGERPATH/bin

SERVERPATH=eXperDBMA
SERVERDBCONF=$SERVERPATH/config/MyBatisConfig.xml
SERVERBIN=$SERVERPATH/bin

PGMHOME=`pwd`
PGMLOG=$PGMHOME/eXperDBMA/log

SERVERLOGDAYS=7

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

#install logo
                PRINT_LOGO() {
                        echo -e " ${GREEN}  "
                        echo "   **********************************"
                        echo "   *    __  __            __  ___   *"
                        echo "   *  __\ \/ /___ ___ _ _|  \|   \  *"
                        echo "   * / _ \  /|- _/ _ ) '_| | | ' /  *"
                        echo "   * \___/  \|_| \___|_| | | | ' \  *"
                        echo "   *    /_/\_\           |__/|___/  *"
                        echo "   **********************************"
                        echo -e " ${NC}"
                        echo "Install eXperDB-PGMON Repository"
                        echo "   "
                }

# Message functions
die() {
    echo -e "${RED}ERROR: $1${NC}" 1>&2
    exit 1
}

usage() {
    echo "usage: `basename $0` [options]"
    echo ""
    echo "Script used to install eXperDB monitoring Repository database for postgresql"
    echo ""
    echo "options:"
    echo "    -h hostname    hostname of the PostgreSQL server"
    echo "    -p port        listening port of the PostgreSQL server"
    echo "    -d dbname      database name of the PostgreSQL server to connect"
    echo "    -U username    username to connect to PostgreSQL"
    echo "    -L licence     License file"
    echo "    -W password    database password of the PostgreSQL server to connect"
    echo "    -D             enable debug mode, will only show what will be done"
    echo "    -y             reply Yes to all questions for automatic import"
    echo "    -?             print help"
    echo
    exit $1
}

# Function to emulate Perl prompt function
confirm () {

    msg=$1
    if [ "$AUTORUN" != "0" ]; then
        true
    else
            if [ -z "$msg" ]; then
                msg="Are you sure? [y/N/q]"
            fi
            # call with a prompt string or use a default
            read -r -p "${msg} [y/N/q] " response
            case $response in
                [yY][eE][sS]|[yY])
                    true
                    ;;
                [qQ][uU][iI][tT]|[qQ])
                    exit
                    ;;
                *)
                    false
                    ;;
            esac
    fi
}

read_passwd()
{
    varname=$2
    var=`eval echo \\\$\${varname}`

    [ -z "$AUTOINS" ] || [ -z "$var" ] || { printf "\n* $1 >>>>> AUTOINS: ******** <<<<<"; return; }

    stty -echo
    password=
    # don't allow empty password
    while [ -z "${password}" ]; do
        printf "$1: "
        read password
    done
    stty echo

    eval $varname=\$password

}


PRINT_LOGO

# Command line options
options_found=0
if (($# == 0)); then
        usage $1;
fi

while getopts "d:h:U:p:L:W:Dy?"  opt; do
        options_found=1
    case "$opt" in
        h) DB_HOST=" -h $OPTARG"
               ORG_DB_HOST="$OPTARG"
               ;;
        U) DB_USER=" -U $OPTARG";
		DB_USER_NAME_ONLY=$OPTARG;;
        p) DB_PORT=" -p $OPTARG"
                   ORG_DB_PORT="$OPTARG"
                   ;;
        d) CONN_DB_NAME=" -d $OPTARG";;
        L) LICENSE_FILE=$OPTARG;;
        W) DB_PASSWORD="$OPTARG";;
        D) DEBUG=1;;
        y) AUTORUN=1;;
        "?") usage 1;;
        *) die "Unknown error while processing options";;
    esac
done

LOCAL_HOST=$DB_HOST

# A connect database user is mandatory
if [ -z "$DB_USER" ]; then
        die "you must give a username to be used as connect to PostgreSQL database (see option)."
fi

# A database hostname is mandatory
if [ -z "$DB_HOST" ]; then
        die "you must give a hostname of the PostgreSQL server to be used as connect to PostgreSQL database (see option)."
fi

# A database port is mandatory
if [ -z "$DB_PORT" ]; then
        die "you must give a port of the PostgreSQL server to be used as connect to PostgreSQL database (see option)."
fi

# A database name is mandatory
if [ -z "$CONN_DB_NAME" ]; then
        die "you must give the name of the PostgreSQL server to be used as connect to PostgreSQL database (see option)."
fi

# Create owner user
if [ -z "$DB_PASSWORD" ] ; then
        read_passwd  "Please enter password for $DB_USER_NAME_ONLY" response
        DB_PASSWORD=$response
fi

if [ -z "$CONN_DB_NAME" ] ; then
        read_passwd  "Please enter password for $DB_OWNER once more" response
        DB_PASSWORD=$response
fi

echo -e "${GREEN}Step.1 Create the databse of owner.${NC}"
user_exists=`PGPASSWORD=$DB_PASSWORD psql$LOCAL_HOST$DB_PORT$DB_USER$CONN_DB_NAME -Atc "select usename from pg_user where usename='$DB_OWNER';"`
if [ $? -eq 0 ]; then
    if [ "a$user_exists" = "a" ]; then
        if confirm "Would you like to create the owner of the database $DB_OWNER?" ; then
            #echo "Running: createuser$DB_HOST$DB_PORT$DB_USER --no-superuser --no-createrole --no-createdb -P $DB_OWNER"
            echo "Running: createuser$LOCAL_HOST$DB_PORT$DB_USER -s -P $DB_OWNER"
            if [ $DEBUG -eq 0 ]; then
                response_confirm=""
                while [ 1 ]; do
                    read_passwd "Enter password for new role" response ; echo -e ""
                    read_passwd "Enter it again" response_confirm; echo -e ""
                    if [ "a$response" != "a$response_confirm"  ] ; then
                        echo "Password and confirm password does not match."
                    else
                        break;
                    fi
                done
                #PGPASSWORD=$DB_PASSWORD createuser$DB_HOST$DB_PORT$DB_USER --no-superuser --no-createrole --no-createdb -P $DB_OWNER
                #PGPASSWORD=$DB_PASSWORD createuser$LOCAL_HOST$DB_PORT$DB_USER -s -P $DB_OWNER
                PGPASSWORD=$DB_PASSWORD createuser$LOCAL_HOST$DB_PORT$DB_USER -s $DB_OWNER 
                if [ $? -ne 0 ]; then
                    die "can not create user $DB_OWNER."
                fi
                PGPASSWORD=$DB_PASSWORD psql$LOCAL_HOST$DB_PORT$DB_USER -c "alter role pgmon with password '$response_confirm'" > /dev/null;
                OWNER_PASSWORD=$response_confirm
            fi
            else
                    die "you must create user $DB_OWNER."
        fi
    else
            echo "Database owner $DB_OWNER already exists, skipping creation."
    fi
else
    exit 1
fi
if [ -z $OWNER_PASSWORD ] ; then
        read_passwd     "Please enter password for $DB_OWNER" response
        OWNER_PASSWORD=$response
fi
echo " "
echo " "
echo -e "${GREEN}Step.2 Create the databse.${NC}"

#Database Name
read -r -p "Input Database name(Default : $DB_NAME) : " response
if [ ! -z "$response" ]; then
        DB_NAME="$response"
fi

DB_ENCODING=`PGPASSWORD=$DB_PASSWORD psql$LOCAL_HOST$DB_PORT$DB_USER$CONN_DB_NAME -Atc "select ' -E ' || pg_encoding_to_char(encoding) || ' --lc-collate=' || datcollate || ' --lc-ctype=' || datctype from pg_database where datname like 'template%' and datallowconn='t';;"`
db_exists=`PGPASSWORD=$DB_PASSWORD psql$LOCAL_HOST$DB_PORT$DB_USER$CONN_DB_NAME -Atc "select datname from pg_database where datname='$DB_NAME';"`
if [ "a$db_exists" = "a" ]; then
    if confirm "Would you like to create the database $DB_NAME?" ; then
        echo "Running: createdb$LOCAL_HOST$DB_PORT$DB_USER$DB_ENCODING --owner $DB_OWNER $DB_NAME"
        if [ $DEBUG -eq 0 ]; then
            PGPASSWORD=$DB_PASSWORD createdb$LOCAL_HOST$DB_PORT$DB_USER$DB_ENCODING --owner $DB_OWNER $DB_NAME
            if [ $? -ne 0 ]; then
                die "can not create database $DB_NAME."
            fi
        fi
        else
                die "you must create database $DB_NAME."
    fi
else
    if confirm "Would you like to drop the database $DB_NAME before recreate it?" ; then
        echo "Running: dropdb$LOCAL_HOST$DB_PORT$DB_USER $DB_NAME"
        if [ $DEBUG -eq 0 ]; then
            PGPASSWORD=$DB_PASSWORD dropdb$LOCAL_HOST$DB_PORT$DB_USER $DB_NAME
            if [ $? -ne 0 ]; then
                die "can not drop database $DB_NAME."
            fi
        fi
        echo "Running: createdb$LOCAL_HOST$DB_PORT$DB_USER$DB_ENCODING --owner $DB_OWNER $DB_NAME"
        if [ $DEBUG -eq 0 ]; then
            PGPASSWORD=$DB_PASSWORD createdb$LOCAL_HOST$DB_PORT$DB_USER$DB_ENCODING --owner $DB_OWNER $DB_NAME
            if [ $? -ne 0 ]; then
                die "can not create database $DB_NAME."
            fi
        fi
    fi
fi

echo " "
echo " "
echo -e "${GREEN}Step.3 Create the schema and tables.${NC}"
schema_exists=`PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -Atc "select nspname from pg_namespace where nspname='$DB_SCHEMA';"`
if [ "a$schema_exists" = "a" ]; then
        echo "Running: psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -c \"CREATE SCHEMA $DB_SCHEMA;\""
        if confirm "Would you like to create schema $DB_SCHEMA in database $DB_NAME?" ; then
                if [ $DEBUG -eq 0 ]; then
                        PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -c "CREATE SCHEMA $DB_SCHEMA;"
                        if [ $? -ne 0 ]; then
                                die "can not create schema $DB_SCHEMA."
                        fi
                fi
        else
                die "you must create schema $DB_SCHEMA."
        fi
else
    if confirm "$DB_SCHEMA schema exists. To proceed with the installation, you have to drop the existing schema!" ; then
        echo "Running: psql $LOCAL_HOST$DB_PORT$DB_USER -d $DB_NAME -c 'drop schema $DB_SCHEMA cascade'"
        if [ $DEBUG -eq 0 ]; then
            PGPASSWORD=$DB_PASSWORD psql$LOCAL_HOST$DB_PORT$DB_USER -d $DB_NAME -c "drop schema $DB_SCHEMA cascade"  > ./install.log 2>&1
            if [ $? -ne 0 ]; then
                die "can not drop database $DB_NAME."
            fi
        fi
        echo "Running: psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -c \"CREATE SCHEMA $DB_SCHEMA;\""
        if [ $DEBUG -eq 0 ]; then
            PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -c "CREATE SCHEMA $DB_SCHEMA;"
            if [ $? -ne 0 ]; then
                die "can not create schema $DB_SCHEMA."
            fi
        fi
    else
        die "Stop the installation."
    fi
fi

if [ -f "$REPOGEN_FILE" ]; then
    echo "Generating $REPOCREATE_FILE"
    sh $REPOGEN_FILE
fi

if [ -r "$REPOCREATE_FILE" ]; then
    echo "Running: psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -f $REPOCREATE_FILE"
        if [ ! -f ${LICENSE_FILE} ]; then
                echo "License is not found!!"
                exit 1
        fi
        LICENSE_STR=`head -n 1 $LICENSE_FILE`
        cp $REPOCREATE_FILE ./pgmon_repository.tmp.sql
        sed -i "s|LICENSEDAT|$LICENSE_STR|g" ./pgmon_repository.tmp.sql

    if [ $DEBUG -eq 0 ]; then
        PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -f ./pgmon_repository.tmp.sql >> ./install.log 2>&1
        if [ $? -ne 0 ]; then
            die "can not import repository data."
        fi
    fi
fi

rm -f ./install.log
rm -f ./pgmon_repository.tmp.sql

echo " "
echo " "
echo -e "${GREEN}Step.4 Configure the IP and Port of the server for connecting eXperDB-Monitoring-client.${NC}"

#AGENT HOST and PORT
read -r -p "Input Agent Host(Default : $ORG_DB_HOST) : " response

if [ -z "$response" ]; then
        # Default AGENT_HOST  is equaled with DB_HOST
        AGENT_HOST="$ORG_DB_HOST"
else
        AGENT_HOST="$response"
fi

read -r -p "Input Agent Port(Default : 5960) : " response

if [ -z "$response" ]; then
        # Default AGENT_HOST  is equaled with DB_HOST
        AGENT_PORT="5960"
else
        AGENT_PORT="$response"
fi

valid_tb_config=`PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -Atc "select 't' as result from tb_config where (select count(*) as cnt from tb_config) > 1;"`
if [ "a$valid_tb_config" = "a" ]; then
        update_tb_config=`PGPASSWORD=$OWNER_PASSWORD psql$LOCAL_HOST$DB_PORT -U $DB_OWNER -d $DB_NAME -Atc "update tb_config set agent_ip = trim('$AGENT_HOST'), agent_port = trim('$AGENT_PORT') \
                          where (select sum(case when regexp_split_to_table = '' then 0 else 1 end) from regexp_split_to_table('$AGENT_HOST', '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$')) = 0 \
                                          and (select sum(case when regexp_split_to_table = '' then 0 else 1 end) from regexp_split_to_table('$AGENT_PORT','^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$')) = 0;"`
        if [ "$update_tb_config" = "UPDATE 1" ]; then
                echo "Complete to install eXperDB-PGMON Repository."
        else
                if [ "$update_tb_config" = "UPDATE 0" ]; then
                        die "Invalid agent host or agent port"
                else
                        echo "Failure to update the agent ip and port of tb_config"
                        die "$update_tb_config"
                fi
        fi

        if [ -f $MANAGERSOCK ] ; then
                sed -i "s/^listenPort=.*/listenPort=$AGENT_PORT/g" $MANAGERSOCK
        else
                die "Couldn't find config file. $MANAGERSOCK"
        fi

        URLPREFIX="jdbc:postgresql:\/\/"
        if [ -f $SERVERDBCONF ] ; then
                OLDURL=`grep url $SERVERDBCONF |cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWURL=$URLPREFIX$ORG_DB_HOST":"$ORG_DB_PORT"\/"$DB_NAME
                sed -i "s/$OLDURL/$NEWURL/g" $SERVERDBCONF
                OLDUSERNAME=`grep username $SERVERDBCONF |cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWUSERNAME=$DB_OWNER
				sed -i 's|<property name="username" value="'$OLDUSERNAME'"|<property name="username" value="'$NEWUSERNAME'"|' $SERVERDBCONF
                OLDPASSWORD=`grep password $SERVERDBCONF |cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWPASSWORD=$OWNER_PASSWORD
				sed -i 's|<property name="password" value="'$OLDPASSWORD'"|<property name="password" value="'$NEWPASSWORD'"|' $SERVERDBCONF
        else
                die "Couldn't find connection file. $SERVERDBCONF"
        fi
        if [ -f $MANAGERDBCONF ] ; then
                OLDURL=`grep url $MANAGERDBCONF  |cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWURL=$URLPREFIX$ORG_DB_HOST":"$ORG_DB_PORT"\/"$DB_NAME
                sed -i "s/$OLDURL/$NEWURL/g" $MANAGERDBCONF
                OLDUSERNAME=`grep username $MANAGERDBCONF |cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWUSERNAME=$DB_OWNER
				sed -i 's|<property name="username" value="'$OLDUSERNAME'"|<property name="username" value="'$NEWUSERNAME'"|' $MANAGERDBCONF
                OLDPASSWORD=`grep password $MANAGERDBCONF|cut -d '"' -f4|sed 's/\//\\\\\//g'`
                NEWPASSWORD=$OWNER_PASSWORD
				sed -i 's|<property name="password" value="'$OLDPASSWORD'"|<property name="password" value="'$NEWPASSWORD'"|' $MANAGERDBCONF
        else
                die "Couldn't find connection file. $MANAGERDBCONF"
        fi
else
        die "table(tb_config) can not have more than one row."
fi

echo export PGMHOME=$PGMHOME >> ~/.experdbrc
echo export PGMLOG=$PGMLOG >> ~/.experdbrc
echo "alias cdms='cd \$PGMHOME'" >> ~/.experdbrc
echo "alias cdml='cd \$PGMLOG'" >> ~/.experdbrc

crontab -l|grep -v eXperDBMA | crontab -
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/find $PGMHOME/eXperDBMA/log/ -maxdepth 1 -ctime +$SERVERLOGDAYS -delete") | crontab -
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/find $PGMHOME/eXperDBMA_MANAGER/log/ -maxdepth 1 -ctime +$SERVERLOGDAYS -delete") | crontab -
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/find $PGMHOME/eXperDBMA/log/ -maxdepth 1 -mtime +$SERVERLOGDAYS -delete") | crontab -
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/find $PGMHOME/eXperDBMA_MANAGER/log/ -maxdepth 1 -mtime +$SERVERLOGDAYS -delete") | crontab -

cat <<-EOF
------------------------------------------------------------------------------
  Thank you for installation eXperDB(R).

  You can now run eXperDB server with command,
  ${SERVERBIN}/experdbma.sh start
  ${MANAGERBIN}/experdbma.sh start
------------------------------------------------------------------------------
EOF

exit 0
