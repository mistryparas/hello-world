pipeline
{
    agent any
     stages {
        stage("Checkout") {
            steps {
              checkout(
                [$class: 'GitSCM',
                branches: [[name: '*/master']],
                extensions: [],
                userRemoteConfigs: [[url: 'https://github.com/mistryparas/hello-world.git']]
                    ]
                )
              }
            }
        stage("Version update") {
            steps {
               sh  '''
               sed -i "s/myproject/nexustest2/g" ${WORKSPACE}/pom.xml 
               sed -i "s/0.0.1-SNAPSHOT/4.0.${BUILD_NUMBER}-SNAPSHOT/g" ${WORKSPACE}/pom.xml '''
            }
        }
        stage("Build") {
            steps {
               sh  '''mvn clean package '''
            }
        }
        stage("Upload Artifcat") {
            steps {
            nexusPublisher nexusInstanceId: 'Nexusrepos', nexusRepositoryId: 'grouptest2', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: './target/nexustest2-4.0.${BUILD_NUMBER}-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'nexustest2', groupId: 'com.example', packaging: 'jar', version: '4.0.${BUILD_NUMBER}-SNAPSHOT']]]
            }
        }
        stage("Build-dockerimage") {
            steps {
              sh '''
              docker build -t nexustest2:4.\${BUILD_NUMBER} .
              '''
            }
        }
        stage("image push") {
            steps {
              sh '''
              docker login -u admin -p redhat 192.168.56.250:9092
              docker tag nexustest2:4.${BUILD_NUMBER} 192.168.56.250:9092/dockertest2:4.0.${BUILD_NUMBER}
              docker push 192.168.56.250:9092/dockertest2:4.0.${BUILD_NUMBER}
              docker rmi -f nexustest2:4.${BUILD_NUMBER} 192.168.56.250:9092/dockertest2:4.0.${BUILD_NUMBER}  '''
            }
        }
        
        
        
        
     }
    post{
        always{
            cleanWs()
            }
        }
}
