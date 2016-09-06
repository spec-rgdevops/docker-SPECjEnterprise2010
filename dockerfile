#
# Oracle Java 8 Dockerfile
#
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#

# Pull base image.
FROM ubuntu:16.04

#install software property managemnet
RUN apt-get update 
RUN apt-get install -y software-properties-common python-software-properties unzip yum ant

# Install Java.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Set environment variables and password for user 'admin'
ENV GLASSFISH_PKG=glassfish-4.1.1.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip \
    GLASSFISH_HOME=/glassfish4 \
    MD5=4e7ce65489347960e9797d2161e0ada2 \
    PATH=$PATH:/glassfish4/bin \
    PASSWORD=password \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Download and extract GlassFish
RUN wget --quiet --no-check-certificate $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG && \
    rm -f $GLASSFISH_PKG 

ADD specjent2010_cd/setup.jar /tmp
RUN java -jar /tmp/setup.jar -i silent && \
    rm /tmp/setup.jar

ADD spec.build.properties /tmp
ADD glassfish.build.properties /tmp
RUN mv /tmp/spec.build.properties /SPECjEnterprise2010-1.03/build.properties && \
    mv /tmp/glassfish.build.properties /SPECjEnterprise2010-1.03/appservers/glassfish/build.properties

ADD specdb.zip /tmp
RUN unzip /tmp/specdb.zip -d / && rm /tmp/specdb.zip

#SPECjEnterprise2010_Driverpatch.zip

ADD SPECjEnterprise2010_OrdersDomainOnlyPatch.zip /tmp/
RUN cd tmp && unzip -j /tmp/SPECjEnterprise2010_OrdersDomainOnlyPatch.zip && \
    mv /tmp/OrderSession.java /SPECjEnterprise2010-1.03/src/java/ejb/org/spec/jent/ejb/orders/session && \
    mv /tmp/PurchaseOrderMDB.java /SPECjEnterprise2010-1.03/src/java/ejb/org/spec/jent/ejb/supplier/mdb && \
    rm /tmp/SPECjEnterprise2010_OrdersDomainOnlyPatch.zip

ADD eclipselink_persistence.xml /SPECjEnterprise2010-1.03/src/resources/ejb/META-INF/persistence.xml

RUN cd /SPECjEnterprise2010-1.03 && \
    ant install && \
    ant specj.ear.withcompile

EXPOSE 4848 8080 8181

ADD start.sh /

CMD ["/bin/bash", "/start.sh"]
