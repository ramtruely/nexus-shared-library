package com.example

class DeploymentUtils {
    static void deployToEnv(String app, String version, String env = 'prod') {
        println "🌐 Deploying ${app}-${version} to ${env}.example.com"
        println "📦 Target: ${env}.example.com:8080/${app}"
    }
}
