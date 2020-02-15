node {

    def icon = ""
    def files
	def result
	
	try {
        // checkout repo locally
		stage('checkout changes from PR') {	
			
			checkout([
				$class: 'GitSCM', 
				branches: [[name: '${ghprbActualCommit}']], 
				doGenerateSubmoduleConfigurations: false, 
				extensions: [], 
				submoduleCfg: [], 
				userRemoteConfigs: [
					[
						name: 'origin', 
						refspec: '+refs/pull/${ghprbPullId}/*:refs/remotes/origin/pr/${ghprbPullId}/*', 
						url: 'https://github.com/afuscella/ABAP-Z-LAC.git']
					]
			])
		}
		
		dir('src') {
			files = findFiles excludes: '', glob: '*.clas.abap'
			for (file in files) {
				echo file.name
			}
		}
	
		// delete current dir before running tests
		deleteDir()
        
		// get pipeline rules
		sh "git clone https://github.com/afuscella/jenkins-pipeline-pvt.git ."
		
		// switch to 'abap' folder
		dir('abap') {

			  sh "newman run collections/get-authentication-token.collection.json " +
			    "-e NPL.environment.json " +
			    "-r cli,junit " +
			    "--insecure " +
			    "--export-environment NPL.environment.json " +
			    "--export-globals globals.json"

			stage('unit test with coverage') {
			  sh "newman run collections/run-unit-test-with-coverage.collection.json " +
			    "-e NPL.environment.json " +
			    "-r cli,junit " +
			    "--insecure " +
			    "--globals globals.json " +
			    "--reporter-junit-export " +
			    "--export-globals globals.json" }

			stage('collect unit test results') {
			  sh "newman run collections/get-unit-test-with-coverage-result.collection.json " +
			    "-e NPL.environment.json " +
			    "-r cli,junit " +
			    "--insecure " +
			    "--reporter-junit-export " +
			    "--globals globals.json" }
		}

		result = 'SUCCESS'
		icon = "completed.gif"
            
    	// error handling
	} catch (err) {
		notify("Failed ${err}")
        
		result = 'FAILURE'
		icon = "delete.gif"
	}

	collectTestResults()
	
	addBadge(icon: icon)

	currentBuild.result = result
    
}

def collectTestResults() {
	try {
		dir('abap') {
			step([
				$class: 'JUnitResultArchiver', 
				testResults: 'newman/*.xml'
			])
		}
	} catch (err) {
		echo ${err}
	}
}

def notify(status){
    emailext (
      to: "your@email.com",
      subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
    )
}

