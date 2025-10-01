### To create a parameterized job in Jenkins, follow these steps:

Step 1: Access Jenkins UI and Login

- Click on the Jenkins button on the top bar to access the Jenkins UI.
- Login using username admin and password Adm!n321.

Step 2: Create a Parameterized Job

- Click on New Item in the Jenkins dashboard.
- Enter parameterized-job as the job name and select Freestyle project.
- Click OK to create the job.

Step 3: Add String Parameter

- In the job configuration page, click on This project is parameterized.
- Click on Add Parameter and select String Parameter.
- Enter Stage as the parameter name and Build as the default value.

Step 4: Add Choice Parameter

- Click on Add Parameter and select Choice Parameter.
- Enter env as the parameter name.
- Enter the following choices:
    - Development
    - Staging
    - Production

Step 5: Configure Shell Command

- In the job configuration page, scroll down to the Build section.
- Click on Add build step and select Execute shell.
- Enter the following shell command: echo "Stage: $Stage" && echo "Environment: $env"

Step 6: Build the Job

- Click on Save to save the job configuration.
- Click on Build with Parameters to build the job.
- Select Development as the environment value and click Build.

Make sure to take screenshots or record your work using a screen recording software like loom.com for review purposes. If you encounter any issues with plugins, restart Jenkins and refresh the UI page.

### To enter the choices for the Choice Parameter in Jenkins, you don't use commas to separate the values. Instead, you enter each choice on a new line.

Here's how to do it:

1. In the Choices field, enter Development and press Enter to move to the next line.
2. Enter Staging and press Enter again.
3. Enter Production on the third line.

The choices should look like this:


Development
Staging
Production


This will create a dropdown list with the specified choices when you build the job.


### What is a Choice Parameter?

A Choice Parameter is a type of parameter in Jenkins that allows users to select a value from a predefined list of options. It's a dropdown list of values that can be used to customize the build process.

Use Case:

The Choice Parameter is useful when you want to provide a set of predefined options to the user, and the build process should behave differently based on the selected option.

Real Scenario Use Case Example:

Let's say you're a DevOps engineer, and you're responsible for deploying a web application to different environments (Dev, QA, Prod). You can create a Jenkins job with a Choice Parameter called "Environment" that allows the user to select the environment where the application should be deployed.

Here's an example:

- Choice Parameter: "Environment"
- Options:
    - Dev
    - QA
    - Prod

Based on the selected environment, the Jenkins job can perform different actions, such as:

- Deploying the application to the selected environment
- Configuring environment-specific settings
- Running environment-specific tests

For example, if the user selects "Dev" as the environment, the Jenkins job can deploy the application to the development environment and configure the settings accordingly.

Benefits:

1. Flexibility: Choice Parameters provide flexibility to the user to select the desired option.
2. Consistency: Choice Parameters ensure that the build process behaves consistently based on the selected option.
3. Error reduction: By providing a predefined list of options, Choice Parameters reduce the chance of errors caused by invalid or incorrect input.

Example Jenkinsfile:

You can use the Choice Parameter in a Jenkinsfile like this:

pipeline {
    agent any
    parameters {
        choice(name: 'Environment', choices: ['Dev', 'QA', 'Prod'], description: 'Select the environment')
    }
    stages {
        stage('Deploy') {
            steps {
                sh "echo Deploying to ${params.Environment}"
                // Deploy to the selected environment
            }
        }
    }
}

In this example, the Jenkinsfile uses the Choice Parameter to determine the environment where the application should be deployed.
