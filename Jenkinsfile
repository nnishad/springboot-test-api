node {
	def mvnHome	
	// Get the Maven tool.
	mvnHome = tool 'MAVEN'
	def applicationName='demo'
	def dockerRepoUrl = "34.122.253.69:8083"
	
	def dockerImage
	def dockerImageTag = "${dockerRepoUrl}/admin/${applicationName}:latest"
	
	
	
	stage('Code checkout') { 
		echo "==========================================Code checkout starts====================================================="
		// Get some code from a GitHub repository
		def repo = "https://github.com/nnishad/springboot-test-api"		
		git repo
		echo "==========================================Code checkout ends====================================================="
	}
	stage ('Clean Up') {
		echo "==========================================Clean Up starts====================================================="
		echo "applicationName---  ${applicationName}"
		sh "rm -rf /tmp/${applicationName}*"
		sh 'docker system prune -a -f' 
		echo "==========================================Clean Up ends====================================================="
	}
		
	stage('Build Code') {
		echo "==========================================Build Code starts====================================================="
		sh "'${mvnHome}/bin/mvn' clean package -Dmaven.test.skip=true"
		
		
		sh "'${mvnHome}/bin/mvn' clean package -U"
		//sh "'${mvnHome}/bin/mvn' clean package -Dmaven.test.skip=true -U"
		sh "cp /var/lib/jenkins/workspace/test-pipeline@2/target/${applicationName}-0.0.1-SNAPSHOT.jar /var/lib/jenkins/workspace/${applicationName}"
		echo "==========================================Build Code ends====================================================="
	}

	stage ('Build Docker Image'){
		echo "==========================================Build Docker Image starts====================================================="			
		echo pwd
		dockerImage = docker.build("admin/${applicationName}")
		
		echo "==========================================Build Docker Image ends====================================================="
	}
	stage('Test image') {

        dockerImage.inside {
            sh 'echo "Tests passed"'
        }
    }
	stage('Application Deployment'){
		echo "==========================================Application Deployment starts====================================================="
		sh 'docker container stop demo-app'
		sh 'docker run --name demo-app -p 5555:8080 -d admin/demo'
		echo "==========================================Application Deployment ends====================================================="
	}
}