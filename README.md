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
    storage_account_name = "tfstate60347593"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "/u9Kubs6n/LcLL9Tgzz9Y1zdRtiQ75im0/4zt0b9Xvs2Dj4DqNKngj47hMBLdsJh9PFhGtjx5LDQ+AStm8PFKA=="
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


