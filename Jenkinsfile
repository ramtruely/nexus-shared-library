library identifier: 'jenkins-shared-lib@3.1.1',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:3.1.1:zip',
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
                    App("myapp", "3.1.1")  // New App function
                }
            }
        }
    }
    
    post {
        success {
            echo "🎉 Nexus Shared Library SUCCESS!"
        }
    }
}
