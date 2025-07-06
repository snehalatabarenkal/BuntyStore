
pipeline {
    agent any

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/snehalatabarenkal/BuntyStore.git'
            }
        }

        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs --format table -o fs-report.html . || true'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=html-site \
                        -Dsonar.projectName=snehalata/html-site \
                        -Dsonar.sources=. \
                        -Dsonar.sourceEncoding=UTF-8'''
                }
            }
        }

        stage('Build & Tag Docker Image') {
            steps {
                script {
                    docker.build('snehalatabarenkal/snehalata/html-site:v1')
                }
            }
        }

        stage('Scan Docker Image with Trivy') {
            steps {
                sh 'trivy image --format table -o image-report.html snehalatabarenkal/snehalata/html-site:v1 || true'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub') {
                        sh 'docker push snehalatabarenkal/snehalata/html-site:v1'
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '*.html', allowEmptyArchive: true
        }
    }
}
