pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = '2'  // Replace with your credentials ID
        GITHUB_REPO = 'i210869-muhammad-hamza/test'  // GitHub repo owner/repo name
        IMAGE_TAG = 'dev'
        DOCKER_REGISTRY = 'ghcr.io'
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
                    sh """
                    docker build -t ${DOCKER_REGISTRY}/${GITHUB_REPO}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            when {
                expression { params.DEPLOY }
            }
            steps {
                echo 'Pushing Docker image to DockerHub...'
                script {
                    withCredentials([usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIALS_ID}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh """
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${DOCKER_REPO}:${params.IMAGE_TAG}
                        """
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
