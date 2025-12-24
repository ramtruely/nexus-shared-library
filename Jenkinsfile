library identifier: 'sbc@1.1.0', retriever: http(
    credentialsId: '',
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any

    stages {
        stage('Check vars / src / resources') {
            steps {
                script {
                    echo '=== VARS: deploy.groovy ==='
                    // Just log, do not really run docker to keep it safe
                    echo 'Calling deploy.toEnvironment() (no real docker run)'
                    deploy.toEnvironment('dev', 'testapp', '1.0.0')

                    echo '=== VARS: utils.groovy → SRC ==='
                    def u = utils()
                    def git = u.gitHelper()
                    def dep = u.deployer()
                    def val = u.validator()

                    echo "Git tag from GitHelper: ${git.getLatestTag()}"
                    echo "Commit from GitHelper: ${git.getCommitHash()}"
                    echo "Validator config: ${val.getConfig()}"

                    echo '=== RESOURCES: config & templates ==='
                    def cfgText = libraryResource('config/default-pipeline.json')
                    echo "default-pipeline.json length: ${cfgText.length()}"

                    def dockerTpl = libraryResource('config/dockerfile-template')
                    echo "dockerfile-template length: ${dockerTpl.length()}"

                    def utilsDoc = libraryResource('config/utils.txt')
                    echo "utils.txt length: ${utilsDoc.length()}"

                    echo '=== SRC direct load sanity check ==='
                    def GitHelperClass = load 'src/com/sbc/utils/GitHelper.groovy'
                    def git2 = new GitHelperClass()
                    echo "Direct load Git tag: ${git2.getLatestTag()}"
                }
            }
        }
    }
}
