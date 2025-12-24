library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any
    stages {
        stage('🔍 LIBRARY CHECKLIST') {
            steps {
                script {
                    echo "=== VARS CHECK ==="
                    deploy.toEnvironment('test', 'app', '1.0') ? "✅ deploy" : "❌ deploy"
                    
                    echo "=== UTILS CHECK ==="
                    def u = utils()
                    echo "utils: ${u ? '✅' : '❌'}"
                    
                    echo "=== RESOURCES CHECK ==="
                    def config = libraryResource('config/default-pipeline.json') ? '✅' : '❌'
                    echo "config: ${config}"
                }
            }
        }
    }
}
