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
                    def u = utils()   // this is the map above

                    echo "🎉 UTILS LOADED!"
                    echo "Map keys: ${u.keySet()}"

                    // Call the closures
                    def g = u.gitHelper()
                    def d = u.deployer()
                    def v = u.validator()

                    echo "Git helper value: ${g}"
                    echo "Deployer value: ${d}"
                    echo "Validator value: ${v}"
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
