library identifier: 'jenkins-shared-lib@2.0.1',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:2.0.1:zip',
          mavenHome: '/usr/share/maven'
        )

pipeline {
    agent any
    stages {
        stage('Test Shared Lib') {
            steps {
                script {
                    hello("Tulasiram")
                    utils.printInfo()
                    App("myapp", "2.0.1")
                }
            }
        }
    }
}
