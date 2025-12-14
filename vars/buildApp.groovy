import com.company.utils.DockerUtils

def call(Map config = [:]) {

    def imageName = config.get('image', 'my-app:latest')

    echo "Starting build for ${imageName}"

    DockerUtils docker = new DockerUtils(this)

    docker.buildImage(imageName)
    docker.pushImage(imageName)
}
