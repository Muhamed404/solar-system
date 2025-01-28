
# Solar System NodeJS Application

A simple HTML + MongoDB + Node.js project to display the Solar System and its planets.

---

## Requirements

To develop and run this application, you will need **Node.js** and **NPM** installed in your environment.

### Node Installation on Windows
1. Visit the official [Node.js website](https://nodejs.org) and download the installer.
2. Ensure Git is available in your PATH, as NPM might require it. [Download Git here](https://git-scm.com/).

### Node Installation on Ubuntu
Run the following commands to install Node.js and NPM using `apt`:
```bash
$ sudo apt install nodejs
$ sudo apt install npm
```

### Installation on Other Operating Systems
Visit the official [Node.js website](https://nodejs.org) and [NPM website](https://www.npmjs.com) for instructions.

### Verify Installation
After installation, run the following commands to check the installed versions:
```bash
$ node --version
v8.11.3

$ npm --version
6.1.0
```

---

## Installation and Usage

### Install Dependencies
To install project dependencies from `package.json`, run:
```bash
$ npm install
```

### Run Unit Testing
To execute the unit tests, run:
```bash
$ npm test
```

### Run Code Coverage
To generate a code coverage report, run:
```bash
$ npm run coverage
```

### Run the Application
To start the application, run:
```bash
$ npm start
```

### Access the Application
Once the application is running, you can access it in your browser at:
```
http://localhost:3000/
```

---

## CI/CD Pipeline Overview

This project includes an automated CI/CD pipeline using Jenkins. The pipeline supports the following:

### Key Features
1. **Slack Notifications**: Sends build status notifications (`STARTED`, `SUCCESS`, `UNSTABLE`, `FAILURE`) to a Slack channel.
2. **Parallel Dependency Scanning**:
   - NPM audit.
   - OWASP Dependency Check.
3. **Unit Testing and Code Coverage**:
   - Executes tests and publishes coverage reports.
4. **Static Application Security Testing (SAST)**: Uses SonarQube for source code analysis.
5. **Docker Integration**:
   - Builds Docker images.
   - Scans images with Trivy for vulnerabilities.
   - Pushes images to Docker Hub.
6. **Kubernetes Deployment with ArgoCD**:
   - Updates Kubernetes manifests stored in the [solar-system-k8s](https://github.com/Muhamed404/solar-system-k8s) repository.
   - Creates a pull request for image tag updates.
   - Deploys to the Kubernetes cluster using ArgoCD.
7. **Dynamic Application Security Testing (DAST)**: Uses OWASP ZAP for scanning web interfaces.
8. **AWS S3 Integration**: Uploads reports to an S3 bucket.
9. **AWS Lambda Deployment**: Prepares, uploads, and deploys the application as a Lambda function.
10. **Approval Gates**: Incorporates manual approvals for production deployments.

---

## Kubernetes Deployment with ArgoCD

### Manifests Repository
The Kubernetes manifests for this project are stored in the following repository:
[solar-system-k8s](https://github.com/Muhamed404/solar-system-k8s)

### Deployment Workflow
1. **Image Tag Update**:
   - Updates the Docker image tag in the Kubernetes manifests.
   - Creates a pull request in the [solar-system-k8s](https://github.com/Muhamed404/solar-system-k8s) repository.
2. **ArgoCD Synchronization**:
   - ArgoCD monitors the `main` branch of the repository.
   - Once the pull request is merged, ArgoCD automatically applies the updated manifests to the Kubernetes cluster.

### Validation
You can verify the deployment using:
- The ArgoCD dashboard.
- The `kubectl` command.

---

## Access Application on Kubernetes
Once deployed to the Kubernetes cluster, access the application at the designated service URL.

---

Let me know if there are additional details you would like to include or modify.
