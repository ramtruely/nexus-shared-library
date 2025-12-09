def call(String name = "World") {
    echo "👋 Hello ${name} from Nexus Shared Library!"
    echo "Build: ${env.BUILD_NUMBER} | Node: ${env.NODE_NAME}"
    return "SUCCESS-${env.BUILD_NUMBER}"
}

