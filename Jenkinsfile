// Load at TOP - makes vars/ global
library identifier: 'jenkins-shared-lib@1.0.0',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:1.0.0:zip:lib',
          mavenHome: '/usr/share/maven'
        )

pipeline {
    agent any
    stages {
        stage('Use Shared Lib') {
            steps {
                // No script {} needed - global now!
                examplePipeline()
            }
        }
    }
}
