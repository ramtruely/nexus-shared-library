@Library('jenkins-shared-lib@1.0.0', 
         retriever: nexus(
           artifactDetails: 'com.example:jenkins-shared-lib:1.0.0:zip:lib',
           mavenHome: '/usr/share/maven'
         )) _

pipeline {
    agent any
    stages {
        stage('Use Shared Lib') {
            steps {
                script {                   
                   examplePipeline()                   
                    
                }
            }
        }
    }
}
