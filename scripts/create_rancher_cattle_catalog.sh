#!/bin/sh
usage(){
  echo "$0 CONFGILE"
}

#replace by config file
replace_by_config(){
FILENAME=$1
  sed -i s/DEMOQUESTIONS/"${QUESTIONS}"/g $FILENAME
  sed -i s/DEMOMINIMUM_VERSION/"${MINVERSION}"/g $FILENAME
  sed -i s/DEMOUUID/"${UUID}"/g $FILENAME
  sed -i s/DEMOPORTMAPPING/"${PORTS}"/g $FILENAME
  sed -i s/DEMOIMAGE/"${IMAGE}"/g $FILENAME
  sed -i s/DEMOURL/"${URL}"/g $FILENAME
  sed -i s/DEMOLICENSE/"${LICENSE}"/g $FILENAME
  sed -i s/DEMOMAINTAINER/"${MAINTAINER}"/g $FILENAME
  sed -i s/DEMOCATAGORY/"${CATAGORY}"/g $FILENAME
  sed -i s/DEMOVERSION/"${VERSION}"/g $FILENAME
  sed -i s/DEMODESCRIPTION/"${DESC}"/g $FILENAME
  sed -i s/DEMONAME/"${CATALOGNAME}"/g $FILENAME
  sed -i s/DEMO/"${CATALOG}"/g $FILENAME
}

#parameter check
if [ $# -ne 1 ]; then
  usage
  exit 1
fi

#CONFILE="./init.conf"
CONFILE="$1"

#file existence check
if [ ! -f $CONFILE ]; then
  echo "CONFIG file : $CONFIG does not exist"
  usage
fi

#get replacements
CATALOG=`cat $CONFILE |grep -w DEMO |awk -F @ '{print $2}' |head -n1 |sed s/' '//g`
CATALOGNAME=`cat $CONFILE |grep -w DEMONAME|awk -F @ '{print $2}' |head -n1`
DESC=`cat $CONFILE |grep -w DEMODESCRIPTION|awk -F @ '{print $2}' |head -n1`
VERSION=`cat $CONFILE |grep -w DEMOVERSION|awk -F @ '{print $2}' |head -n1`
CATAGORY=`cat $CONFILE |grep -w DEMOCATAGORY|awk -F @ '{print $2}' |head -n1`
MAINTAINER=`cat $CONFILE |grep -w DEMOMAINTAINER|awk -F @ '{print $2}' |head -n1`
LICENSE=`cat $CONFILE |grep -w DEMOLICENSE|awk -F @ '{print $2}' |head -n1`
URL=`cat $CONFILE |grep -w DEMOURL|awk -F @ '{print $2}' |head -n1`
IMAGE=`cat $CONFILE |grep -w DEMOIMAGE|awk -F @ '{print $2}' |head -n1`
PORTS=`cat $CONFILE |grep -w DEMOPORTMAPPING|awk -F @ '{print $2}' |head -n1`
UUID=`cat $CONFILE |grep -w DEMOUUID|awk -F @ '{print $2}' |head -n1`
MINVERSION=`cat $CONFILE |grep -w DEMOMINIMUM_VERSION|awk -F @ '{print $2}' |head -n1`
QUESTIONS=`cat $CONFILE |grep -w DEMOQUESTIONS|awk -F @ '{print $2}' |head -n1`

#copy base direcotry from DEMO
cp -pR DEMO ${CATALOG}

#rename template catalog name
mv ${CATALOG}/templates/DEMO ${CATALOG}/templates/${CATALOG}

#rename svg icon name
mv ${CATALOG}/templates/${CATALOG}/catalogIcon-DEMO.svg ${CATALOG}/templates/${CATALOG}/catalogIcon-${CATALOG}.svg

#replace config.yml
replace_by_config ${CATALOG}/templates/${CATALOG}/config.yml

#replace docker-compose.yml
replace_by_config ${CATALOG}/templates/${CATALOG}/0/docker-compose.yml

#replace rancher-compose.yml
replace_by_config ${CATALOG}/templates/${CATALOG}/0/rancher-compose.yml
