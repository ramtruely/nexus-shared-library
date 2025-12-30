FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk wget apt-transport-https ca-certificates gnupg curl \
    ansible python3-pip \
    && wget -q -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
    && echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list \
    && apt-get update && apt-get install -y jenkins \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/jenkins_home/plugins /var/jenkins_home/jobs

RUN groupadd -r jenkins && useradd -r -g jenkins -m jenkins \
    && chown -R jenkins:jenkins /var/jenkins_home /var/lib/jenkins /var/log/jenkins

RUN plugins="workflow-cps-global-lib-http git-client workflow-aggregator ws-cleanup antisamy-markup-formatter" \
    && for p in $plugins; do \
         curl -fsSL https://updates.jenkins.io/latest/${p}.hpi -o /var/jenkins_home/plugins/${p}.hpi; \
       done \
    && chown -R jenkins:jenkins /var/jenkins_home

RUN echo '#!/bin/bash\n\
su jenkins -c "/usr/bin/java -Djenkins.install.runSetupWizard=false -jar /usr/share/jenkins/jenkins.war --httpPort=8080 &"\n\
JENKINS_PID=$!\n\
sleep 90\n\
echo "Jenkins ready - get initial password from /var/lib/jenkins/secrets/initialAdminPassword"\n\
wait $JENKINS_PID' > /start-jenkins.sh \
    && chmod +x /start-jenkins.sh

VOLUME ["/var/jenkins_home"]
EXPOSE 8080
CMD ["/start-jenkins.sh"]
