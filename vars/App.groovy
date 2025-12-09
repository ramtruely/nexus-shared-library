def call(String appName, String version) {
    echo "🚀 Deploying ${appName} v${version}"
    
    stage("Build ${appName}") {
        sh """
            echo "Building ${appName}-${version}..."
            sleep 2
            echo "✅ Build complete: ${appName}-${version}.tar.gz"
        """
    }
    
    stage("Deploy ${appName}") {
        sh """
            echo "Deploying to production..."
            sleep 3
            echo "✅ Deployed: ${appName}-${version} -> prod.example.com"
        """
    }
}
