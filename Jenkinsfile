library identifier: 'jenkins-shared-lib@1.0.0',
        retriever: nexus(
          artifactDetails: 'com.example:jenkins-shared-lib:1.0.0:zip',
          mavenHome: '/usr/share/maven'
        )

pipeline {
    agent any
    
    stages {
        stage('Hello') {
            steps {
                script {
                    def result = hello("Ram")  // Calls vars/hello.groovy
                    echo "Result: ${result}"
                }
            }
        }
        
        stage('Utils') {
            steps {
                script {
                    utils.printInfo()  // Calls vars/utils.groovy
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    deployApp("myapp", "1.2.3")  // Calls vars/deployApp.groovy
                }
            }
        }
    }
    
    post {
        always {
            hello("Pipeline Complete!")  // Global function call
        }
    }
}
