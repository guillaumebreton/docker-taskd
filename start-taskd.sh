#!/bin/sh -eu

if [ ! -d $TASKDATA ]; then
  taskd init
fi

# Generate self sign certificate
if [ ! -f $TASKDATA/ca.cert.pem ]; then
  touch /var/taskdata/config
  # Change the CN based on the env var
  sed -i "s|CN.*|CN=$SIGN_CN|g" vars_test && cat vars_test
  cd /var/taskd
  cd pki && ./generate
  cp client.cert.pem $TASKDATA
  cp client.key.pem  $TASKDATA
  cp server.cert.pem $TASKDATA
  cp server.key.pem  $TASKDATA
  cp server.crl.pem  $TASKDATA
  cp ca.cert.pem     $TASKDATA
  taskd config --data $TASKDATA --force client.cert $TASKDATA/client.cert.pem
  taskd config --data $TASKDATA --force client.key $TASKDATA/client.key.pem
  taskd config --data $TASKDATA --force server.cert $TASKDATA/server.cert.pem
  taskd config --data $TASKDATA --force server.key $TASKDATA/server.key.pem
  taskd config --data $TASKDATA --force server.crl $TASKDATA/server.crl.pem
  taskd config --data $TASKDATA --force ca.cert $TASKDATA/ca.cert.pem
  taskd config --data $TASKDATA --force log $TASKDATA/taskd.log
  taskd config --data $TASKDATA --force pid.file $TASKDATA/taskd.pid
  taskd config --data $TASKDATA --force server 0.0.0.0:53589

fi

echo "Configuration"
taskd config --data $TASKDATA
echo "start taskd on $TASKDATA"
taskd server --data  $TASKDATA
