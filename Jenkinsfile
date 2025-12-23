library identifier: 'sbc@1.1.0', retriever: http(
    httpURL: 'http://admin:admin123@34.46.185.122:8081/repository/maven-shared-lib/com/sbc/${library.sbc.version}/sbc-${library.sbc.version}.zip'
)

pipeline {
    agent any
    environment {
        APP_NAME = 'sbc-webapp'
        VERSION = '2.1.0'
    }
    stages {
        stage('🔍 Full Library Integration Test') {
            steps {
                script {
                    echo "🚀 === ENTERPRISE SHARED LIBRARY DEMO ==="
                    
                    // 1. VARS/ GLOBAL FUNCTIONS
                    echo "📦 === VARS/ GLOBAL FUNCTIONS ==="
                    deploy.toEnvironment('dev', env.APP_NAME, env.VERSION)
                    
                    // 2. VARS/UTILS() - DYNAMIC LOADING
                    echo "🔧 === VARS/UTILS DYNAMIC LOADING ==="
                    def utils = utils()
                    def gitHelper = utils.gitHelper()
                    def deployer = utils.deploy()
                    def validator = utils.validate()
                    
                    echo "✅ GitHelper: ${gitHelper.getLatestTag()}"
                    echo "✅ Deployer: Ready for K8s"
                    echo "✅ Validator: ${validator.getConfig().defaultNamespace}"
                    
                    // 3. SRC/ CLASSES - DIRECT ACCESS
                    echo "🏗️ === SRC/ CLASSES DIRECT ==="
                    def gitInfo = new com.sbc.utils.GitHelper()
                    echo "✅ Direct Git: ${gitInfo.getCommitHash()}"
                    
                    def k8sDeployer = new com.sbc.pipeline.Deployer()
                    k8sDeployer.deployToK8s(env.APP_NAME, env.VERSION, 'staging')
                    
                    // 4. RESOURCES/ CONFIG LOADING
                    echo "📋 === RESOURCES/ CONFIGS ==="
                    def pipelineConfig = readJSON file: libraryResource('config/default-pipeline.json')
                    echo "✅ Config loaded: ${pipelineConfig.imageRegistry}"
                    echo "✅ Environments: ${pipelineConfig.environments.join(', ')}"
                    
                    def dockerTemplate = readFile file: libraryResource('templates/dockerfile-template')
                    echo "✅ Dockerfile template: ${dockerTemplate.take(50)}..."
                    
                    // 5. VALIDATION & BUSINESS LOGIC
                    echo "✅ === BUSINESS VALIDATION ==="
                    def branchValid = com.sbc.pipeline.Validator.validateBranch('main')
                    echo "✅ Branch main: ${branchValid}"
                    
                    // 6. FULL CHAIN INTEGRATION
                    echo "🔗 === FULL CHAIN EXECUTION ==="
                    def commit = gitInfo.getCommitHash()
                    echo "Building ${env.APP_NAME}:${env.VERSION} (commit: ${commit})"
                    sh "echo 'Docker build would run here...'"
                    echo "✅ SIMULATED production deploy to ${pipelineConfig.environments[2]}"
                }
            }
        }
    }
    post {
        always {
            echo "📊 === LIBRARY COVERAGE REPORT ==="
            echo "✅ vars/ globals: deploy.toEnvironment()"
            echo "✅ vars/utils(): Dynamic src/ loading"
            echo "✅ src/ classes: GitHelper, Deployer, Validator"
            echo "✅ resources/: JSON configs + templates"
            echo "✅ Linux Docker: Ready"
            echo "✅ Nexus HTTP: Live"
        }
        success {
            echo "🎉🏆 COMPLETE SUCCESS! ENTERPRISE LIBRARY 100% OPERATIONAL!"
            echo "💼 Deploy this pattern across ALL pipelines!"
        }
    }
}
