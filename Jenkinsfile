library(
  identifier: 'fact@1.1.0',
  retriever: nexus(
    artifactDetails: 'com.fact:fact:${library.fact.version}:zip:lib',
    mavenHome: '/usr/share/maven'
  )
) _

pipeline {
    agent any

    stages {
       stage("build") {
            steps {
                script {
                    examplePipeline()
                }
            }
        }
