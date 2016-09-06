#/bin/sh
set -e
ADMIN_PORT=4848
touch /glassfish4/glassfish/passwordfile
echo "AS_ADMIN_PASSWORD=${PASSWORD}" > /glassfish4/glassfish/passwordfile
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-domain --adminport $ADMIN_PORT specjent2010
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile start-domain specjent2010

#provide correct details of your database setup
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jdbc-connection-pool --datasourceclassname org.apache.derby.jdbc.EmbeddedDataSource --steadypoolsize 200 --maxpoolsize 200 --property user=sa:password=sa:databaseName=/specdb specjpool
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.resources.jdbc-connection-pool.specjpool.property.ImplicitCachingEnabled=true
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.resources.jdbc-connection-pool.specjpool.property.MaxStatements=200
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jdbc-resource --connectionpoolid specjpool jdbc/SPECjLoaderDS
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jdbc-resource --connectionpoolid specjpool jdbc/SPECjOrderDS
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jdbc-resource --connectionpoolid specjpool jdbc/SPECjMfgDS
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jdbc-resource --connectionpoolid specjpool jdbc/SPECjSupplierDS
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-module-config transaction-service 
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.transaction-service.property.db-logging-resource=jdbc/SPECjMfgDS
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=8080
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.thread-pools.thread-pool.http-thread-pool.max-thread-pool-size=40
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.thread-pools.thread-pool.http-thread-pool.min-thread-pool-size=40
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.transports.transport.tcp.acceptor-threads=2
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.protocols.protocol.http-listener-1.http.max-connections=310000
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.thread-pools.thread-pool.http-thread-pool.max-queue-size=310000
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.transports.transport.tcp.max-connections-count=310000
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.protocols.protocol.http-listener-1.http.timeout-seconds=-1
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.http-service.access-logging-enabled=false
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set configs.config.server-config.network-config.protocols.protocol.http-listener-1.http.xpowered-by=false
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.iiop-service.iiop-listener.orb-listener-1.port=3700
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.thread-pools.thread-pool.thread-pool-1.max_thread_pool_size=40
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.thread-pools.thread-pool.thread-pool-1.min_thread_pool_size=40
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-module-config ejb-container
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.ejb-container.steady_pool_size=60
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.ejb-container.max_pool_size=60
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.ejb-container.max_cache_size=1
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-module-config mdb-container
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.mdb-container.max_pool_size=45
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT set server.mdb-container.steady_pool_size=45
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/WorkOrderQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/FulfillOrderQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/LargeOrderQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/ReceiveQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/BuyerQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/PurchaseQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.QueueConnectionFactory jms/LoaderQueueConnectionFactory
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=BuyerQueue jms/BuyerQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=FulfillOrderQueue jms/FulfillOrderQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=LargeOrderQueue jms/LargeOrderQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=ReceiveQueue jms/ReceiveQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=WorkOrderQueue jms/WorkOrderQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=LoaderStatusQueue jms/LoaderStatusQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=LoaderQueue jms/LoaderQueue
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jms-resource --restype javax.jms.Queue --property imqDestinationName=PurchaseOrderQueue jms/PurchaseOrderQueue

echo 'ENABLE remote access to admin console (port $ADMIN_PORT)'
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT enable-secure-admin
echo 'DEPLOY SPECj.EAR'
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT deploy --force --name specj /SPECjEnterprise2010-1.03/target/jar/specj.ear

echo 'Modify server for SPECjEnterprise Performance Improvements'
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT delete-jvm-options -client
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT delete-jvm-options -Xmx512m
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jvm-options -server
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jvm-options -Xms2g
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jvm-options -Xmx6g
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jvm-options -Dderby.system.durability=test
/glassfish4/glassfish/bin/asadmin --user admin --passwordfile /glassfish4/glassfish/passwordfile --port $ADMIN_PORT create-jvm-options -Dderby.storage.pageCacheSize=150000

echo 'restarting the domain'
/glassfish4/glassfish/bin/asadmin stop-domain specjent2010
/glassfish4/glassfish/bin/asadmin start-domain -v specjent2010
echo 'READY TO BENCHMARK!'
