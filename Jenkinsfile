
pipeline {
    agent any 
        tools {
            jdk 'openjdk17'
            maven 'Maven-3.6.3'
        }
    stages {
      stage (version) {
        steps {
            sh ''' mvn -version
            java --version '''
        }
      }
      stage("Checkout") {
      	steps {
          checkout([$class: 'GitSCM',
          branches: [[name: '*/myproject2']],
          extensions: [],
          userRemoteConfigs: [[url: 'https://github.com/mistryparas/hello-world.git']]]
          )
        }
      }
      stage("Clean Package") {
        steps {
            sh ''' mvn clean package '''
        }
      }
      stage("build") {
        steps {
            sh '''VERSION=$(printf 'VER\t${project.version}' | mvn help:evaluate | grep '^VER' | cut -f2| cut -d "-" -f1) 
            mvn deploy -P docker-latest -P docker-random -DBUILD_NUMBER=s${VERSION}-${BUILD_NUMBER} ''' 
        }
      }
      stage("export Env") {
       	steps {
       	  script {
       	      env.VER= sh (returnStdout: true,script: '''echo $(printf 'VER\t${project.version}' | mvn help:evaluate | grep '^VER' | cut -f2| cut -d "-" -f1)-${BUILD_NUMBER}''')
       	  }
       	  sh '''echo "new $VER"'''
       // 	build job: 'CD-backend', parameters: [$class: 'StringParameterValue', name: 'image', value: '8.0.${BUILD_NUMBER}'], wait: true	
         build job: 'CD-backend', parameters: [string(name: 'image', value: "$VER")], wait: true  
       	}
      }
    }
    post{
      always{
        cleanWs()
        }
      }
}
