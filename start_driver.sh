#/bin/sh
echo SLEEPING;
sleep 120;
# while ! nc -z specj_server 8080; do
#   echo SLEEPING;
#   sleep 3;
# done

cd /SPECjEnterprise2010-1.03
ant -v deploy-on-harness