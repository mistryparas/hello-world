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










      }
}
