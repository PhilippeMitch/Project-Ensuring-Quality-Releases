# Udacity DevOps Engineer for Microsoft Azure Nanodegree Program 

## Project Starter
This repository contains the starter code for the **Ensuring Quality Releases** project of the cd1807 Ensuring Quality Releases (Quality Assurance) course taught by Nathan Anderson. 

## Project Overview
![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/overview.png)
In this project, you'll develop and demonstrate your skills in using a variety of industry leading tools, especially Microsoft Azure, to create disposable test environments and run a variety of automated tests with the click of a button. Additionally, you'll monitor and provide insight into your application's behavior, and determine root causes by querying the application’s custom log files.

### How to use?
- Fork this repository to your Github account and clone it locally for further development. 
- Follow the classroom instructions, and check the rubric before a submission. 

### Suggestions and Corrections
Feel free to submit PRs to this repo should you have any proposed changes. 

### Here is the high-level sequence of the tasks
1. Create the following Azure infrastructure using Terraform:
   * Resource group
   * App Service
   * Virtual Machine (VM). The VM will also require Virtual Network and Network Security Group.
 2. Create the Postman integration test suite containing Data Validation and Regression tests.
 3. Create the Stress test and Endurance test suites using JMeter.
 4. Create Funtional UI test suite using Selenium and output the print statements to a log file.
 5. Configure Azure Log Analytics to ingest the Selenium log file.
 6. Add the all of the above test suites to the Azure DevOps CI/CD pipeline. For Postman test suite to excute in the CI/CD pipeline, ensure that Postman CLI is installed in the agent VM, and the starter API collection is correctly referenced.
 7. Finally, create an alert for the App service in the Azure portal using Azure Monitor service.

### Azure Resources
* Azure Storage account
* Azure Log Analytics
* Web App
* Azure Virtual Machines
* Azure DevOps

### Project Environment
In order to complete this project, you'll need:
* Terraform
* JMeter
* Postman
* Selenium
* A Microsoft Azure account. If you dos not have one yet you can [create one](https://login.microsoftonline.com).

## Instruction

### Terraform
1. Fork this repository to your Github account and clone it locally for further development.
2. Open a Terminal and connect to your Azure account to get the Subscription ID.
   ```bash
   az login 
  az account list --output table
  ```
3. Create a storage account to Store Terraform state.
```bash
cd Project-Ensuring-Quality-Releases
cd terraform/environments/test
chmod +x configure-tfstate-storage-account.sh
./configure-tfstate-storage-account.sh
```
4. Update the storage account details (name, container name, and access key) in the terraform/environments/test/main.tf file with the values returned.
```bash
terraform {
  backend "azurerm" {
    storage_account_name = "<the returned storage account name>"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "<the returned access key value>"
  }
}
```
5. Go to Azure Portal --> **Microsoft Intra ID** --> **App registration** --> Select your application.<br>
   There you will be able to find Application client Id and Directory tenant. For Secrets and click on **Certificates & secrets**.<br>
   Update the corresponding values in terraform/environments/test/terraform.tfvars.
   ```bash
   # Azure subscription vars
    subscription_id = "xxxxxxxxxxxx"
    client_id = "xxxxxxxxxxxx"
    client_secret = "xxxxxxxxxxxx"
    tenant_id = "xxxxxxxxxxxx"
   ```
### Azure DevOps Pipeline
1. Go to https://dev.azure.com/ using Udacity provide account to create new AzureDevops project
2. Install below extensions :
   * [JMeter](https://marketplace.visualstudio.com/items?itemName=AlexandreGattiker.jmeter-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList)
   ![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/jmeter-extension.png)
   * [PublishHTMLReports](https://marketplace.visualstudio.com/items?itemName=LakshayKaushik.PublishHTMLReports&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList)
   ![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/publish-html-report-extension.png)
   * [Terraform](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks&targetId=625be685-7d04-4b91-8e92-0a3f91f6c3ac&utm_source=vstsproduct&utm_medium=ExtHubManageList)
   ![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/terraform-extension.png)
3. Create a Service Connection
   In Azure devops go to **Project Settings** > **Pipelines** > **Service Connection** > **Azure Resource Manager** > **Service principal(automatic)**
4. Create an Agent Pool, and an Agent
  In Azure DevOps go to **Project Settings** > **Agent pools** > **Add pool**
   * For the Pool type choose *Self-Hosted*
   * Type a name for the agent pool (e.g., myAgentPool)
5. Create a VM to use as an Agent
   In Azure Portal go to the Virtual machines page, select Create and then Azure virtual machine. The Create a virtual machine page opens.
   
|                      Field	                  |                          Value                      |
|-----------------------------------------------|-----------------------------------------------------|
| Subscription                                  | Choose existing                                     |
| Resource group                                | Choose existing                                     |
| Virtual machine name                          | Type a name for your VM                             |
| Availability options                          | No infrastructure redundency required               |
| Region                                        | Select the region same that of the resource group   |
| Image                                         | Ubuntu Server 22.04 LTS - Gen1                      |
| Size                                          | Standard_DS1_v2                                     |
| Authentication type                           | Password                                            |
| Username                                      | Type a username                                     |
| Password                                      | Type a password and confirm the password            |
| Public inbound ports                          | Allow selected ports <br>Select inbound ports: SSH (22) |

6. Configure the Agent (VM)
   The agent VM will perform the pipeline jobs, such as building your code residing in Github and deploying it to the Azure services. This step will let you authenticate the agent via a Personal Access Token (PAT) generated from your DevOps account.
   * Run the following commands from an Azure cloud shell or terminal or command prompt. Replace the IP address as applicable to you.
     ```bash
     ssh username@17.37.97.22
     ```
     Accept the default prompts and provide the username and password as you have set up in the last step above.
     * Install Docker
       ```bash
       sudo snap install docker
       ```
     * Configure the user user to run Docker.
       ```bash
       sudo groupadd docker
      sudo usermod -aG docker $USER
      exit
     ```
     You will have to log back in using the same SSH command
7. Configure the Agent (VM) - Install Agent Services
   Go back to the DevOps portal, and open the newly created Agent pool to add a new agent. Follow the instructions [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-agent?view=azure-devops)
   ![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/agent-pool-1.png)
   In you Azure DevOps, navigate to Organization Settings > Agent Pools > myAgentPool and then select the Agents tab. Confirm that the self-hosted agent is online.
   ![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/agent-pool.png)
8. Once your VM will be ready using the final pipeline, you will have to SSH log into the machine to run Selenium functional (UI) tests.
  ```bash
      ssh-keygen -t rsa
      cat ~/.ssh/id_rsa.pub
  ```
Update the terraform/modules/vm/vm.tf
```bash
admin_ssh_key {
  username   = "adminuser"
  public_key = "<id_rsa.pub output>"
}
```
9. Create a DevOps Pipeline
Navigate to the DevOps project, and select Pipeline and create a new one. You will use the following steps:
  * Connect - Choose the Github repository as the source code location.
  * Select - Select the Github repository containing the exercise starter code.
  * Configure - Choose the Existing Azure Pipelines YAML file option.
  * Click on the **Run** button
![](https://github.com/PhilippeMitch/Project-Ensuring-Quality-Releases/blob/main/screenshots/pipelines-done.png)
