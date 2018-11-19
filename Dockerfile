FROM openshift/jenkins-slave-base-centos7
MAINTAINER Gerald Nunn <gnunn@redhat.com>

ENV SBT_VERSION 1.2.6
ENV SCALA_VERSION 2.12.7
ENV IVY_DIR=/var/cache/.ivy2
ENV SBT_DIR=/var/cache/.sbt

USER root

RUN INSTALL_PKGS="sbt-$SBT_VERSION" \
 && curl -s https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo \
 && mv bintray-sbt-rpm.repo /etc/yum.repos.d/ \
 && yum install -y --enablerepo=centosplus $INSTALL_PKGS \
 && rpm -V $INSTALL_PKGS \
 && yum install -y https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.rpm \
 && yum clean all -y

# Create local cache but creates large image of 1.98 GB
# COPY plugins.sbt /tmp

# RUN mkdir -p /tmp/caching/project $IVY_DIR $SBT_DIR \
#  && cd /tmp/caching \
#  && echo "sbt.version = $SBT_VERSION" > project/build.properties \
#  && echo "scalaVersion := \"$SCALA_VERSION\"" > build.sbt \
#  && mv /tmp/plugins.sbt project \
#  && sbt -v -sbt-dir $SBT_DIR -sbt-boot $SBT_DIR/boot -ivy $IVY_DIR compile \
#  && chown -R 1001:0 $IVY_DIR \
#  && chmod -R g+rw $IVY_DIR \
#  && chown -R 1001:0 $SBT_DIR \
#  && chmod -R g+rw $SBT_DIR \
#  && rm -rf /tmp/*

USER 1001
