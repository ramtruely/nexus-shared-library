library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any

    stages {
        stage('Validate vars + src + resources') {
            steps {
                script {
                    echo '=== START INTEGRATION CHECK ==='

                    // Call vars/utils.groovy
                    def u = utils()
                    echo "utils() keys: ${u.keySet()}"

                    // Call closures that indirectly hit src + resources
                    echo "App name from utils: ${u.getAppName()}"
                    echo "Default env from utils: ${u.getDefaultEnv()}"
                    echo "Registry from utils: ${u.getRegistry()}"

                    echo '=== END INTEGRATION CHECK ==='
                }
            }
        }
    }

    post {
        success {
            echo '✅ vars + src + resources integration OK'
        }
    }
}
