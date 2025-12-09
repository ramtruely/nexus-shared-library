def call(String name = "World") {
    def buildInfo = com.example.BuildInfo.buildDetails
    def nodeInfo = com.example.BuildInfo.nodeInfo
    
    echo "👋 Hello ${name} from Nexus Shared Library!"
    echo "${buildInfo} | Node: ${nodeInfo}"
    return "SUCCESS-${env.BUILD_NUMBER}"
}
