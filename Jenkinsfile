pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = '2'  // DockerHub credentials ID
        DOCKER_REPO = 'muhammadhamzacpp/check' // Replace with DockerHub username/repo
    }

    parameters {
        booleanParam(name: 'DEPLOY', defaultValue: true, description: 'Enable deployment?')
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Tag for the Docker image')
    }

    stages {
        stage('Check for Code Changes') {
            steps {
                echo 'Checking for code changes...'
                git url: 'https://github.com/i210869-muhammad-hamza/test.git', branch: 'main'
                script {
                    def changes = sh(script: "git diff --name-only HEAD~1 HEAD", returnStdout: true).trim()
                    if (changes == "") {
                        error("No code changes detected. Skipping pipeline.")
                    } else {
                        echo "Code changes detected:\n${changes}"
                    }
                }
            }
        }
        stage('Install Python and Pip') {
            steps {
                    echo 'Installing Python and pip...'
                    sh '''
                    apt-get update
                    apt-get install -y python3 python3-pip
                    '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Python dependencies...'
                // Ensure Python and pip are installed on the Jenkins agent
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Run Build and Test Pipeline') {
            steps {
                echo 'Running build and tests...'
                sh 'unittest --maxfail=1 --disable-warnings test.py'
            }
        }

        stage('Create Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_REPO}:${params.IMAGE_TAG} ."
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
