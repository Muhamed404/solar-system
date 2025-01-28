# Solar System NodeJS Application

A simple HTML+MongoDB+NodeJS project to display Solar System and it's planets.

---
## Requirements

For development, you will only need Node.js and NPM installed in your environement.

### Node
- #### Node installation on Windows

  Just go on [official Node.js website](https://nodejs.org/) and download the installer.
Also, be sure to have `git` available in your PATH, `npm` might need it (You can find git [here](https://git-scm.com/)).

- #### Node installation on Ubuntu

  You can install nodejs and npm easily with apt install, just run the following commands.

      $ sudo apt install nodejs
      $ sudo apt install npm

- #### Other Operating Systems
  You can find more information about the installation on the [official Node.js website](https://nodejs.org/) and the [official NPM website](https://npmjs.org/).

If the installation was successful, you should be able to run the following command.

    $ node --version
    v8.11.3

    $ npm --version
    6.1.0

---
## Install Dependencies from `package.json`
    $ npm install

## Run Unit Testing
    $ npm test

## Run Code Coverage
    $ npm run coverage

## Run Application
    $ npm start

## Access Application on Browser
    http://localhost:3000/


    Jenkinsfile Documentation
Purpose
This Jenkinsfile defines a CI/CD pipeline for a Node.js application. It automates various stages such as code checkout, dependency installation, security scans, unit testing, Docker image management, and deployment to AWS, Kubernetes (via ArgoCD), and AWS Lambda. The pipeline integrates with tools like SonarQube, OWASP Dependency Check, Trivy, and ZAP.

Key Features
1.Slack Notifications: Notifies the build status (STARTED, SUCCESS, UNSTABLE, FAILURE) in a Slack channel.
2.Node.js Support: Specifies the Node.js version to use (nodejs-22-6-0).
Parallel Dependency Scanning:
NPM audit.
OWASP Dependency Check.
Unit Testing and Code Coverage:
Executes tests and publishes coverage reports.
Static Application Security Testing (SAST): Uses SonarQube for source code analysis.
Docker Integration:
Builds Docker images.
Scans images with Trivy for vulnerabilities.
Pushes images to Docker Hub.
Kubernetes Deployment with ArgoCD:
Updates Kubernetes manifests stored in the solar-system-k8s repository.
Creates a pull request for image tag updates.
Deploys to the Kubernetes cluster using ArgoCD.
Dynamic Application Security Testing (DAST): Uses OWASP ZAP for scanning web interfaces.
AWS S3 Integration:
Uploads reports to an S3 bucket.
AWS Lambda Deployment:
Prepares, uploads, and deploys the application as a Lambda function.
Approval Gates: Incorporates manual approvals for production deployments.

Pipeline Stages
1. Clean Workspace
Cleans the workspace to ensure no artifacts from previous builds remain.

2. Checkout Code
Pulls the latest code from the repository.

3. Installing Dependencies
Installs project dependencies using npm.

4. Dependency Scanning
NPM Audit: Scans for critical vulnerabilities in NPM dependencies.
OWASP Dependency Check: Identifies known vulnerabilities in dependencies.
5. Unit Testing
Runs unit tests and captures results for Jenkins.

6. Code Coverage
Publishes code coverage reports to Jenkins.

7. Static Application Security Testing (SAST)
Analyzes source code with SonarQube for code quality and vulnerabilities.

8. Build Docker Image
Builds a Docker image of the application and tags it with the Git commit hash.

9. Trivy Vulnerability Scanner
Scans the Docker image for vulnerabilities and publishes reports.

10. Push Docker Image
Pushes the built Docker image to Docker Hub.

11. Provision AWS EC2
Uses Terraform to provision EC2 instances.

12. Deploy on AWS EC2
Deploys the application to the provisioned EC2 instance.

13. Integration Testing
Runs integration tests on the deployed application.

14. Destroy AWS EC2
Tears down the EC2 environment post-integration testing.

15. Kubernetes Image Update
Description
This stage updates the Docker image tag in Kubernetes manifests stored in the solar-system-k8s repository.

Actions
Clones the repository: https://github.com/Muhamed404/solar-system-k8s.
Updates the deployment.yml file to include the new Docker image tag.
Commits and pushes the changes to a new feature branch.
Raises a pull request to merge the updated manifests into the main branch.
Commands
bash
Copy
Edit
git clone -b main https://github.com/Muhamed404/solar-system-k8s
cd solar-system-k8s/kubernetes
sed -i "s#muhamedk.*#muhamedk/solar-system:$GIT_COMMIT#g" deployment.yml
git checkout -b feature-$BUILD_ID
git add .
git commit -m "Update Docker Image"
git push -u origin feature-$BUILD_ID
16. Kubernetes Deployment with ArgoCD
Description
Once the manifests are updated in the main branch of the repository, ArgoCD automatically synchronizes the changes to deploy the updated application to the Kubernetes cluster.

Actions
Waits for a manual confirmation (APP Deployed? stage) to ensure the PR is merged and ArgoCD has synchronized the changes.
ArgoCD pulls the updated manifests from the main branch of the repository and applies them to the Kubernetes cluster.
ArgoCD Details
Manifests Repository: solar-system-k8s
Synchronization: ArgoCD continuously monitors the main branch for updates to automatically apply changes.
Validation: You can verify the deployment by inspecting the ArgoCD dashboard or using the kubectl command.
17. Dynamic Application Security Testing (DAST)
Uses OWASP ZAP to scan the application for runtime vulnerabilities.

18. Upload Reports to AWS S3
Uploads test and scan reports to an S3 bucket for centralized storage.

19. Approval for Production Deployment
Includes a manual approval step for deploying to production.

20. AWS Lambda Deployment
Prepares, uploads, and deploys the application as a Lambda function.

21. Invoke Lambda Function
Validates the deployed Lambda function by invoking it.

This structure ensures that Kubernetes Image Update and Kubernetes Deployment with ArgoCD are logically integrated into the pipeline stages, maintaining proper sequencing. Let me know if you need further refinements!

