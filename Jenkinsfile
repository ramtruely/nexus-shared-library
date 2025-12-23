library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any
    stages {
        stage('FINAL TEST') {
            steps {
                script {
                    def gitInfo = new com.sbc.utils.GitHelper()
                    echo "✅ GitHelper WORKS: ${gitInfo.getLatestTag()}"
                }
            }
        }
    }
}
