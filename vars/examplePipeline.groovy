// vars/examplePipeline.groovy
def call() {
    echo "Shared library loaded successfully!"
    
    pipeline {
        agent any
        stages {
            stage('Example Stage') {
                steps {
                    script {
                        // Use env.BUILD_ID or currentBuild instead of 'build'
                        echo "Build ID: ${env.BUILD_ID}"
                        echo "Build URL: ${env.BUILD_URL}"
                        sh 'echo "Hello from Nexus shared library!"'
                    }
                }
            }
        }
    }
}
