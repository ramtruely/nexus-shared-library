--- For Nexus retrieval
//library identifier: 'jenkins-shared-lib@3.1.1',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:3.1.1:zip',
          mavenHome: '/usr/share/maven'
        )
//
---
# Jenkins shared library example

This repository contains an example project for deploying a Jenkins shared library to Nexus.

## Usage

### Library deployment

Upload this library to Nexus using e.g. `mvn clean deploy`.

Release this library using e.g. `mvn release:prepare release:perform`.

### Plugin and library configuration

Then, in Jenkins, ensure that the [pipeline-global-lib-nexus-plugin](https://github.com/jenkinsci/pipeline-global-lib-nexus-plugin) is installed.

In Jenkins, navigate to 'Manage Jenkins -> Configure System' and scroll down to ' Global Pipeline Libraries'.
Add the library using the following details (one time):

```text
Library Name: jenkins-lib
Default version: develop
Retrieval method: Nexus
Artifact details: com.roylenferink.jenkins.libraries:jenkins-shared-library-example:${library.jenkins-lib.version}:zip
MAVEN_HOME: /tools/maven/3.9.0/
```

### Library usage

The library can now be used in pipeline jobs. E.g. create a new pipeline job with the following pipeline script:

```groovy
library 'jenkins-lib@1.0.6'
examplePipeline()
```

