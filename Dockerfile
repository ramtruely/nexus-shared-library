FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV JENKINS_HOME=/var/jenkins_home
ENV JENKINS_MIRROR=https://updates.jenkins.io

# Install Java, Jenkins, Ansible, and dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    apt-transport-https \
    ca-certificates \
    gnupg \
    curl \
    ansible \
    python3-pip \
    && wget -q -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
    && echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list \
    && apt-get update && apt-get install -y jenkins \
    && rm -rf /var/lib/apt/lists/*

# Jenkins user setup
RUN usermod -a -G sudo jenkins && echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install plugins
RUN mkdir -p ${JENKINS_HOME}/plugins \
    && plugins="workflow-cps-global-lib-http git-client workflow-aggregator ws-cleanup antisamy-markup-formatter" \
    && for plugin in $plugins; do \
         curl -fsSL ${JENKINS_MIRROR}/latest/${plugin}.hpi -o ${JENKINS_HOME}/plugins/${plugin}.hpi; \
       done

# Token generation script
RUN echo '#!/bin/bash\n\
set -e\n\
JENKINS_URL=http://localhost:8080\n\
JENKINS_USER=admin\n\
JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)\n\
TOKEN_FILE=${JENKINS_HOME}/token.txt\n\
\n\
# Start Jenkins first\n\
sudo -u jenkins /usr/bin/java -jar /usr/share/jenkins/jenkins.war --httpPort=8080 &\n\
JENKINS_PID=$!\n\
\n\
# Wait for startup\n\
sleep 30\n\
until curl -s -u ${JENKINS_USER}:${JENKINS_PASS} ${JENKINS_URL}/login | grep -q "Jenkins"; do sleep 5; done\n\
\n\
# Generate token if missing\n\
if [ ! -f ${TOKEN_FILE} ]; then\n\
  TOKEN=$(curl -s -u ${JENKINS_USER}:${JENKINS_PASS} "${JENKINS_URL}/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken" \\\n\
    --data-urlencode "newTokenName=ansible-token" | python3 -c "import sys,json;print(json.load(sys.stdin)[\"data\"][\"tokenValue\"])")\n\
  echo ${TOKEN} > ${TOKEN_FILE}\n\
  echo "Token preserved: ${TOKEN}"\n\
fi\n\
\n\
wait ${JENKINS_PID}' > /start-jenkins.sh \
    && chmod +x /start-jenkins.sh

# Copy your Jenkinsfile as job config (convert to XML first or use template)
COPY Jenkinsfile ${JENKINS_HOME}/jobs/my-pipeline/config.xml

VOLUME ["${JENKINS_HOME}"]
EXPOSE 8080
CMD ["/start-jenkins.sh"]
