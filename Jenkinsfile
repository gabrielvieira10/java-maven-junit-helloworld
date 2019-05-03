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
        stage('Step counter') {
            steps {
                script {
                    dir('.') {
                        sh 'echo "Step counter stage"'
                        stepcounter settings: [[encoding: 'UTF-8', filePattern: 'src/main/**/*.java', filePatternExclude: '', key: 'Java'], [encoding: 'UTF-8', filePattern: 'src/test/**/*.java', filePatternExclude: '', key: 'TestCode']]
                    }
                }
            }
        }
    }
    post {
        always {
            recordIssues enabledForFailure: true, tool: checkStyle()
            recordIssues enabledForFailure: true, tool: spotBugs()
        }
    }

}
