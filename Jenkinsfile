pipeline
{
   agent any
     stages {
         stage("Checkout") {
            steps {
               checkout(
               [$class: 'GitSCM',
               branches: [[name: '*/automation']],
               extensions: [],
               userRemoteConfigs: [[url: 'https://github.com/mistryparas/hello-world.git']]])
            }
         }
         stage("Version update") {
            steps {
               sh  '''sed -i "s/0.0.1-SNAPSHOT/0.0.${BUILD_NUMBER}-SNAPSHOT/g" ${WORKSPACE}/pom.xml '''
            }
        }
        stage("Build") {
            steps {
               sh  '''mvn clean package '''
            }
        }
        stage("Upload Artifcat") {
            steps {
            nexusPublisher nexusInstanceId: 'Nexusrepos', nexusRepositoryId: 'maven-mytest', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/CI-automation/target/automation-0.0.${BUILD_NUMBER}-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'automation', groupId: 'com.example', packaging: 'jar', version: '0.0.${BUILD_NUMBER}-SNAPSHOT']]]
            }
        }
        stage("Build-dockerimage") {
            steps {
            sh '''
            docker build -t automation:0.\${BUILD_NUMBER} .
            '''
            }
        }
        stage("image push") {
            steps {
              sh '''
              docker login -u admin -p redhat 192.168.56.250:8086
              docker tag automation:0.\${BUILD_NUMBER} 192.168.56.250:8086/dockertest/automation:0.0.\${BUILD_NUMBER}
              docker push 192.168.56.250:8086/dockertest/automation:0.0.\${BUILD_NUMBER}
              docker rmi -f automation:0.\${BUILD_NUMBER} 192.168.56.250:8086/dockertest/automation:0.0.\${BUILD_NUMBER}
              '''
            }
        }
        stage("CD-automation") {
         steps {
          script { 
            env.BID="${BUILD_NUMBER}"
            //env.image_name= sh (returnStdout: true,script: '''echo  $(printf 'VER\t${project.version}' | mvn help:evaluate | grep '^VER' | cut -f2| cut -d "-" -f1) ''')
            //def trim=sh (returnStdout: true,script: '''echo ${image_name}''').trim()
            //env.image="${trim}-${BID}"
            build job: 'CD-pipeline', parameters: [string(name: 'image', value: "0.0.${BID}") ], wait: true}
        }
      }







      }
}
