library identifier: 'jenkins-shared-lib@1.0.0',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:1.0.0:zip',
          mavenHome: '/usr/share/maven'
        )

pipeline {
    agent any
    stages {
        stage('Use Lib') {
            steps {
                examplePipeline.deployApp()
            }
        }
    }
}
