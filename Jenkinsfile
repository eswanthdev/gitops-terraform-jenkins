// Jenkinsfile
//String credentialsId = 'awsCredentials'
String AWS_ACCESS_KEY_ID = ${env.AWS_ACCESS_KEY_ID}
String AWS_SECRET_ACCESS_KEY = ${env.AWS_SECRET_ACCESS_KEY}
String AWS_DEFAULT_REGION = ${env.AWS_DEFAULT_REGION}

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  // Run terraform init
  stage('init') {
    node {
//      withCredentials([[
//        $class: 'AmazonWebServicesCredentialsBinding',
//        credentialsId: 'awsCredentials',
//        AWS_ACCESS_KEY_ID: 'Access Key ID',
//        AWS_SECRET_ACCESS_KEY: 'Secret Access Key'
//        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
//        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'        
//      ]]) {
        ansiColor('xterm') {
          sh 'terraform init'
        }
      }
    }
  }

  // Run terraform plan
  stage('plan') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
          sh 'terraform plan'
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    // Run terraform apply
    stage('apply') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    // Run terraform show
    stage('show') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh 'terraform show'
          }
        }
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}
