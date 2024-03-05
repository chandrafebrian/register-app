pipeline {
    agent { label 'jenkins-agent' }
    tools {
        jdk 'Java17Chandra'
        maven 'Maven3Chandra'
    }
    environment {
	        APP_NAME = "register-app-pipeline"
            RELEASE = "1.0.0"
            DOCKER_USER = "chandraf80"
            DOCKER_PASS = 'dockerhub'
            IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
            IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	        JENKINS_API_TOKEN = credentials("JENKINS_API_TOKEN")
            // JENKINS_URL = 'http://34.87.133.46:8080'
            // JENKINS_USERNAME = 'chandrajenkinsadmin'
    }
    stages{
        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }

        stage("Checkout from SCM"){
                steps {
                    git branch: 'main', credentialsId: 'github-chan', url: 'https://github.com/chandrafebrian/register-app'
                }
        }

        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

       }

       stage("Test Application"){
           steps {
                 sh "mvn test"
           }
       }

       stage("SonarQube Analysis"){
           steps {
	           script {
		        withSonarQubeEnv(credentialsId: 'jenkins-sonar-token') { 
                        sh "mvn sonar:sonar"
		        }
	           }	
           }
       }

       stage("Quality Gate"){
           steps {
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonar-token'
                }	
            }

        }

        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

       }

       stage("Trivy Scan") {
           steps {
               script {
	            sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image chandraf80/register-app-pipeline:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
               }
           }
       }

       stage ('Cleanup Artifacts') {
           steps {
               script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
               }
          }
       }

       stage("Trigger CD Automate Pipeline") {
            steps {
                script {
                    sh "curl -v -k --user chandrajenkinsadmin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H '34.87.133.46:8080/job/gitops-register-app-cd/buildWithParameters?token=gitops-token'"
                }
            }
       }

    // stages {
    //     stage('Build') {
    //         steps {
    //             // Use credentials binding to securely inject API token
    //             withCredentials([usernamePassword(credentialsId: 'JENKINS_API_TOKEN', usernameVariable: 'JENKINS_USERNAME', passwordVariable: 'JENKINS_API_TOKEN')]) {
    //                 sh '''
    //                     curl -v -k --user "${JENKINS_USERNAME}:${JENKINS_API_TOKEN}" -X POST -H "cache-control: no-cache" "${JENKINS_URL}/job/gitops-register-app-cd/buildWithParameters?token=gitops-token"
    //                 '''
    //             }
    //         }
    //     }
    // }

//     post {
//        failure { 
//              emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
//                       subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed", 
//                       mimeType: 'text/html',to: "ashfaque.s510@gmail.com"
//       }
//       success {
//             emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
//                      subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful", 
//                      mimeType: 'text/html',to: "ashfaque.s510@gmail.com"
//       }      
//    }
}
