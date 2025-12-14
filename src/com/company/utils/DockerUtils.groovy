package com.company.utils

class DockerUtils implements Serializable {

    def steps

    DockerUtils(steps) {
        this.steps = steps
    }

    def buildImage(String imageName) {
        steps.echo "Building Docker image: ${imageName}"
        steps.sh "docker build -t ${imageName} ."
    }

    def pushImage(String imageName) {
        steps.echo "Pushing Docker image: ${imageName}"
        steps.sh "docker push ${imageName}"
    }
}
