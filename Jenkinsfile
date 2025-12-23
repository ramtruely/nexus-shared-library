library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any
    stages {
        stage('Test vars/utils.groovy') {
            steps {
                script {
                    // ✅ Call utils() - gets ALL utilities
                    def u = utils()
                    
                    echo "🎉 UTILS LOADED!"
                    echo "Git helper available: ${u.gitHelper}"
                    echo "Deploy helper available: ${u.deploy}"
                    echo "Validate helper available: ${u.validate}"
                }
            }
        }
    }
    post {
        success {
            echo "✅ vars/utils.groovy WORKS PERFECTLY!"
        }
    }
}
