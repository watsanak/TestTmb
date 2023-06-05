stages {
       agent any   

       stage('Checkout Code From Git') {
           steps {
               script {
                    git 'https://github.com/watsanak/TestTmb.git'
               }
           }
       }
       stage('Run Test Automate') {
           steps {
                
                        // Execute your Robot Framework tests and generate output files
                       // sh 'robot --outputdir output tests/'
                        sh("robot -L TRACE:DEBUG -d results -i test_tmb testcase")                     
               
           }
       }
       stage('Send Result To Jenkins') {
           steps {
                // Publish the Robot Framework test results in Jenkins
                script {
                    dir("results") {
                    robot outputPath: '.',
                    logFileName: "log.html",
                    outputFileName: "output.xml",
                    reportFileName: "report.html"
                    }
                }
           }
        }
    }
