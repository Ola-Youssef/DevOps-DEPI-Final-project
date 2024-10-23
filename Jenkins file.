pipeline {
    agent any

    environment {
        ENVIRONMENT = 'DEV'
        HOST = '0.0.0.0'
        PORT = '5000'
        REDIS_HOST = 'redis'
        REDIS_PORT = '6379'
        REDIS_DB = '0'
        DOCKER_IMAGE_NAME = 'olayoussef/my_python_app'  
    }

    triggers {
        githubPush()
    }

    stages {
        
        stage('Build and Push Docker Image') {
            steps {
                script {
                    
                    sh 'docker build -t my_python_app .'
                    
                    
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'pass', usernameVariable: 'dockerhubuser')]) {
                        sh 'docker login -u $dockerhubuser -p $pass'
                        sh 'docker tag my_python_app:latest $DOCKER_IMAGE_NAME:latest'
                        sh 'docker push $DOCKER_IMAGE_NAME:latest'
                    }
                }
            }
        }

        stage('Run App') {
            steps {
                script {
                    sh '''
                    # Clean up any existing containers
                    docker rm -f my_python_app || true
                    docker rm -f redis || true
                    # Run the application
                    docker-compose up -d
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                sh 'docker exec my_python_app python tests/test.py'  // Replace with your actual test command
            }
        }

        stage('Deploy') {
            when {
                expression {
                    return currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        always {
            
            sh 'docker-compose down --volumes'
        }
        success {
            mail to: 'olayoubadr@gmail.com, maram.hassan95@gmail.com, basantehab83@gmail.com, saifdawoodcs@gmail.com, noor.mohamed.eisa@gmail.com',
                 subject: "Build Succeeded: ${env.BUILD_TAG}",
                 body: "The build was successful. Check the logs for details."
        }
        failure {
            mail to: 'olayoubadr@gmail.com, maram.hassan95@gmail.com, basantehab83@gmail.com, saifdawoodcs@gmail.com, noor.mohamed.eisa@gmail.com',
                 subject: "Build Failed: ${env.BUILD_TAG}",
                 body: "The build failed. Please check the logs."
        }
    }
}
