pipeline {
    agent any
    environment {
        IMAGE_NAME = "selenium-test"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }
        stage('Run Selenium Tests') {
            steps {
                script {
                    // Run the Docker container and execute the tests
                    sh 'docker run --rm $IMAGE_NAME'
                }
            }
        }
    }
    post {
        always {
            // Cleanup: remove any unused images, volumes, etc.
            sh 'docker system prune -af'
        }
    }
}
