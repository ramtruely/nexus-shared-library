library identifier: 'sbc@1.1.0', retriever: http(
   credentialsId: 'artifactory-creds',
   httpURL: 'http://34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip')


pipeline {
    agent any
    stages {
        stage('Test Shared Lib') {
            steps {
                script {
                    hello("Tulasiram")
                    utils.printInfo()
                    
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
