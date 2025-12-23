library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip')

pipeline {
    agent any
    stages {
        stage('Validate & Utils') {
            steps {
                script {
                    def u = utils()
                    echo "Latest Git tag: ${u.gitHelper().getLatestTag()}"
                    echo "Pipeline config: ${validate().getConfig()}"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    deploy.toEnvironment('dev', 'myapp', '1.0.0')
                }
            }
        }
    }
}
