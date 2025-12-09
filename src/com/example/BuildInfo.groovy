package com.example

class BuildInfo {
    static String getBuildDetails() {
        return "Build#${System.getenv('BUILD_NUMBER') ?: 'local'} | ${new Date().format('yyyy-MM-dd HH:mm:ss')}"
    }
    
    static String getNodeInfo() {
        return System.getenv('NODE_NAME') ?: 'local-node'
    }
}
