pipeline {
    agent { label 'jenkins-agent' }
    tools {
        jdk 'java17chandra'
        maven 'maven3chandra'
    }
     environment {
        APP_NAME = "register-app-pipeline"
        RELEASE = "1.0.0"
        // ✅ Gunakan credentialsId, bukan string literal
        DOCKER_USER = "chandraf80"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        // JENKINS_API_TOKEN = credentials("JENKINS_API_TOKEN")
    }
    
    stages{
        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }

        stage("Checkout from SCM"){
                steps {
                    git branch: 'main', credentialsId: 'github-chandra', url: 'https://github.com/chandrafebrian/register-app'
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

                    env.JAVA_HOME = tool('java17chandra')
                    env.MAVEN_JAVA_HOME = tool('java17chandra')
                    env.PATH = "${env.JAVA_HOME}/bin:${env.PATH}"
                    
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
                    // ✅ FIX #1: Include tag saat build
                    docker_image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                    
                    // ✅ FIX #2: Gunakan credentialsId yang benar
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }

        tage("Trivy Scan") {
            steps {
                script {
                    sh '''
                        echo "=== Trivy Security Scan (Offline Mode) ==="
                        
                        TRIVY_BIN="/home/chandrafebrian/bin/trivy"
                        
                        # ✅ Use offline-scan to avoid /tmp space issues
                        $TRIVY_BIN image \
                            ${IMAGE_NAME}:latest \
                            --no-progress \
                            --scanners vuln \
                            --offline-scan \
                            --exit-code 0 \
                            --severity HIGH,CRITICAL \
                            --format table
                            
                        echo "✅ Trivy scan completed"
                    '''
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

    //    stage("Trigger CD Automate Pipeline") {
    //         steps {
    //             script {
    //                 sh "curl -v -k --user chandra:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' '35.213.144.36:8080/job/gitops-register-app-cd/buildWithParameters?token=gitops-token'"
    //             }
    //         }
    //    }

        // post {
        //     failure { 
        //             emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
        //                     subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed", 
        //                     mimeType: 'text/html',to: "chandrafebrian99@gmail.com"
        //     }
        //     success {
        //             emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
        //                     subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful", 
        //                     mimeType: 'text/html',to: "chandrafebrian99@gmail.com"
        //     }      
        // }
    }
}