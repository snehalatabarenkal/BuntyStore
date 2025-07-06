pipeline {
    agent any

    stages {
        stage('Clone HTML Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/snehalatabarenkal/BuntyStore.git'
            }
        }

        stage('Serve HTML using Python') {
            steps {
                sh '''
                    echo "Starting Python HTTP Server..."
                    cd $WORKSPACE
                    nohup python3 -m http.server 8081 &
                '''
            }
        }
    }
}

