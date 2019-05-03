pipeline {
    options{
        timeout(time:1,unit:'HOURS')
    }
    environment {
        docker_image_name = "java8-maven3-junit5"
    }
    
    agent {
    dockerfile {
        additionalBuildArgs '--no-cache=true --build-arg "JENKINS_USER_ID=112" --build-arg "JENKINS_GROUP_ID=117" --build-arg "DOCKER_GROUP_ID=999"'
        args '--group-add 117 --group-add 999 -v ${PWD}/.m2:/usr/share/maven/.m2'
        dir '.'
        filename 'Dockerfile'
        label env.docker_image_name
        }
    }
    stages {
        stage('maven execution') {
            steps {
                script {
                    dir('.') {
                        sh 'id'
                        sh 'set HTTP_PROXY=$HTTP_PROXY'
                        sh 'set HTTPS_PROXY=$HTTP_PROXY'
                        sh 'mvn clean package site'
                    }
                }
            }
        }
        stage('Analysis') {
            steps {
                script {
                    dir('.') {
                        sh 'echo "Analysis stage"'
                        def checkstyle = scanForIssues tool: [$class: 'CheckStyle'], pattern: '**/checkstyle.xml'

                        def findbugs = scanForIssues tool: [$class: 'FindBugs']

                        recordIssues(
                            enabledForFailure: true, aggregatingResults: true, 
                            tools: [findbugs(), checkStyle(pattern: 'checkstyle.xml', reportEncoding: 'UTF-8')]
                        )
                    }
                }
            }
        }
    }

}
