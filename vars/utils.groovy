def getBuildInfo() {
    return [
        number: env.BUILD_NUMBER,
        url: env.BUILD_URL,
        timestamp: new Date(),
        node: env.NODE_NAME
    ]
}

def printInfo() {
    def info = getBuildInfo()
    echo "📊 Build Info:"
    echo "- Number: ${info.number}"
    echo "- URL: ${info.url}"
    echo "- Time: ${info.timestamp}"
    echo "- Node: ${info.node}"
}
