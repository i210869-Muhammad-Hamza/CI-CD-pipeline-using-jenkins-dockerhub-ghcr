pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = '2'  // Replace with your Docker credentials ID
        DOCKER_REPO = 'muhammadhamzacpp/check' // Replace with your DockerHub username/repo
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the GitHub Repository...'
                git(
                    branch: 'main',
                    url: 'https://github.com/i210869-muhammad-hamza/test.git',
                    credentialsId: '1'
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker Image...'
                script {
                    sh "docker build -t ${DOCKER_REPO}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Pushing the Docker Image to Docker Hub...'
                script {
                    withCredentials([usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIALS_ID}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${DOCKER_REPO}:${IMAGE_TAG}
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
