pipeline {
    agent any
    tools {
        maven "MAVEN3.9"
        jdk "jdk17"
    }

    stages {
        stage('Fetch code') {
            steps {
                git branch: 'atom', url: 'https://github.com/ganeshnarapareddy'
            }
        }

        stage('UNIT TEST') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn install -DskipTests'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Sonar Code Analysis') {
            environment {
                scannerHome = tool 'sonar6.2'
            }
            steps {
                withSonarQubeEnv('sonarserver') {
                    sh '''
                    ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=vprofile \
                        -Dsonar.projectName=vprofile \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/ \
                        -Dsonar.java.binaries=target/classes/ \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml \
                        -Dsonar.host.url=http://34.229.15.23 \
                        -Dsonar.login=squ_b2a9e7e9cb1d04f12c362683477a27dac14d3f7e
                    '''
                }
            }
        }


        stage("UploadArtifact") {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '54.172.32.148:8081',
                    groupId: 'QA',
                    version: "${env.BUILD_ID}-${new Date().format('yyyyMMddHHmmss')}",  // Ensuring timestamp is set
                    repository: 'vprofile-repo',
                    credentialsId: 'nexuslogin',
                    artifacts: [
                        [artifactId: 'vproapp',
                         classifier: '',
                         file: 'target/vprofile-v2.war',
                         type: 'war']
                    ]
                )
            }
        }
    }
}
