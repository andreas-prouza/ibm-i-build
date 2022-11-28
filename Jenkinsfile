pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo "PWD: `pwd`"
                sh 'pwd'
            }
        }
        stage('Sync') {
            steps {
                echo "rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','build','logs','.vscode','.project','.gitignore'}  ${workspaceFolder}/ prouza@academy:/home/prouza/myproject/"
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}