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

        stage('Push Docker Image to GitHub Packages') {
            steps {
                echo 'Pushing the Docker Image to GitHub Packages...'
                script {
                    withCredentials([usernamePassword(
                        credentialsId: '1',
                        usernameVariable: 'GITHUB_USERNAME',
                        passwordVariable: 'GITHUB_TOKEN'
                    )]) {
                        sh '''
                        echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin
                        '''
                        //docker push ${DOCKER_REGISTRY}/${GITHUB_REPO}:${IMAGE_TAG}
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
