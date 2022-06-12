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
            nexusPublisher nexusInstanceId: 'Nexusrepos', nexusRepositoryId: 'maven-mytest', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '${WORKSPACE}/target/automation-0.0.${BUILD_NUMBER}-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'automation', groupId: 'com.example', packaging: 'jar', version: '0.0.${BUILD_NUMBER}-SNAPSHOT']]]
            }
        }









      }
}
