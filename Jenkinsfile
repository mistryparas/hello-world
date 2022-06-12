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
   }
}

