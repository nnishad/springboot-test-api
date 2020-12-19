node {
	def mvnHome	
	// Get the Maven tool.
	mvnHome = tool 'MAVEN'
	def applicationName='demo'
	def dockerRepoUrl = "10.128.15.197:8081"
	
	def dockerImage
	def dockerImageTag = "${dockerRepoUrl}/${applicationName}:0.0.1"
	
	
	
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
		
		sh "docker login -u admin -p admin ${dockerRepoUrl}"
      	sh "docker tag ${applicationName} ${dockerImageTag}"
      	sh "docker push ${dockerImageTag}"
		
		echo "==========================================Build Docker Image ends====================================================="
	}
	stage('Application Deployment'){
		echo "==========================================Application Deployment starts====================================================="
		//sh "chmod +x runContainer.sh"
		//sh "nohup ./runContainer.sh ${applicationName} > /dev/null 2>&1 &"
		//sh 'chmod +x runContainer.sh'
		//sh 'nohup ./runContainer.sh > /dev/null 2>&1 &'
			
		def publishPort=8087
		def applicationPort=8087
		///sh "helm list"
		sh "chmod +x /var/lib/jenkins/workspace/${applicationName}@libs/dxp-pipeline-library2/vars/runContainer.sh"
		sh "bash  /var/lib/jenkins/workspace/${applicationName}@libs/dxp-pipeline-library2/vars/runContainer.sh ${applicationName} ${publishPort} ${applicationPort}"		
		echo "==========================================Application Deployment ends====================================================="
	}
}