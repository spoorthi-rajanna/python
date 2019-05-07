pipeline {
    agent any
    stages {
    
    
        stage('checkout') {

            steps {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/mibrahim2019/python.git']]])
            }
        }
        stage('Build') {

            steps {
                sh 'python -m py_compile app.py config.py fabfile.py forms.py models.py'
            }
        }
          /* stage('Test') { 

            steps {
                sh 'py.test --verbose --junit-xml test-reports/results.xml app.py config.py fabfile.py forms.py models.py' 
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }  */
        
         
          stage('Package') {

            steps {
                sh 'pyinstaller --onefile app.py'
            }

        } 


                 stage('nexus') {
            steps {
                echo 'uploading to nexus....'

nexusPublisher nexusInstanceId: '12345', nexusRepositoryId: 'nexus_test', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'build/app/PKG-00.pkg']], mavenCoordinate: [artifactId: '${JOB_NAME}', groupId: 'pythonApp', packaging: 'pkg', version: '1.0.${BUILD_NUMBER}']]]
            }

        } 
        
         stage('Deploy') {
            steps {
                sh """ 
               wget "http://3.9.43.71:8081/repository/nexus_test/pythonApp/Imagination_python_project/1.0.${BUILD_NUMBER}/Imagination_python_project-1.0.${BUILD_NUMBER}.pkg"

                
                """
sshPublisher(publishers: [sshPublisherDesc(configName: 'ansuble_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook deploy.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'build/app/*.pkg')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])        }
    }
}
}
