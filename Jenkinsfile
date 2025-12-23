library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any
    stages {
        stage('Test Library Load') {
            steps {
                script {
                    // Test direct vars/ calls (don't need utils())
                    echo "Library loaded! Testing deploy.toEnvironment..."
                    deploy.toEnvironment('dev', 'testapp', '1.0.3')
                }
            }
        }
    }
}
