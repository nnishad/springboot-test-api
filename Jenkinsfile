node {
	def mvnHome	
	// Get the Maven tool.
	mvnHome = tool 'MAVEN'
	def applicationName='demo'
	def dockerRepoUrl = "34.122.253.69:8083"
	def NexusDockerRegistryUrl= "34.122.253.69:8083"
	def dockerImage
	def dockerImageTag = "${dockerRepoUrl}/admin/${applicationName}:latest"
	
	
	


	stage('Push Docker Images to Nexus Registry'){
			echo "==========================================Build Docker Image starts====================================================="			
		dockerImage = docker.build("admin/${applicationName}")		
	
		sh 'docker login -u admin -p admin ${dockerRepoUrl}'
		sh 'docker push ${dockerRepoUrl}/${applicationName}'
		sh 'docker rmi $(docker images --filter=reference="${dockerRepoUrl}/${applicationName}*" -q)'
		sh 'docker logout ${dockerRepoUrl'
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