## About

While many tools (that enable devops practice and culture) are available for applications deployment to machines in the cloud, doing so with having no downtime while maintaining simplicity in the deployment process is a testament to the usefulness of the tools when it comes to enabling devops.

Though a single tool may empower methods such as infrastructure as code, continuous integration and deployment and immutability, it is important to measure the strengths of each tool against the value it adds to the devops culture in place as methods are subservient to values.

Tools should simplify methods and methods in turn should encourage learning in the devops lifecycle.

The aim of this project is to make use of industry standard tools to eliminate the window of time  when switching a node serving an application in the cloud from a currrent version to a new version. In a production environment, this is considered a down time when the node serving the application is unavailable to users. These are the methods implemented in this project and the tools that help achieve these methods:


### Methods
- infrastructure as code
- continuous deployment
- immutability
- idempotence

### Tools
- Apache
- Puppet
- Packer
- Terraform
- Atlas
- Amazon Web Services (AWS)
- Git
- Ubuntu

### Requirements to Run this Project
- [AWS Account](https://console.aws.amazon.com/) 
- [Atlas Account](https://atlas.hashicorp.com/account/new)

### Content
- app folder : A simple sample application to be deployed
- packer folder : An amazon machine image (AMI) created for launching nodes
- terraform folder : Infrastructure turned into code

### Delivery Pipeline and Image Deploys Process

![Delivery Flow](/workflow.jpg)

Packer runs in Atlas to build the application AMI which is provisioned and configured using Puppet. This creates an  artifact that is stored in [Atlas](https://atlas.hashicorp.com). 

Terraform then reads from the artifact registry and deploys new instances using this AMI. When the application AMI is updated, the process starts again – continuous delivery for immutable infrastructure. New nodes are created when change takes place in the AMI or the infrastructure itself, then old nodes are destroyed with the former occuring first to avoid downtime during the process.


### How To Run This Project (Part 1: Building the Artifact)
- Ensure you have an [Atlas Account](https://atlas.hashicorp.com/account/new) and [AWS Account](https://console.aws.amazon.com/).
- Install [Packer](https://www.packer.io/downloads.html) and [Terraform](https://www.terraform.io/downloads.html)
- Clone [this](https://github.com/CruzanCaramele/ZeroDownTime) repository.
- From the directory **Zero_DownTime/ops/packer** acess the **main.json** file and enter your **Atlas** and **AWS** credentails in the variables section or follow these [instructions](https://www.packer.io/docs/templates/user-variables.html) to set the variables as environmental variables.
- On a command line program such as Git, from within the directory **Zero_DownTime/ops/packer** execute the command **packer push main.json**. This uploads the packer file and provisioners to your [Atlas Account](https://atlas.hashicorp.com).
- From your Atlas account , navigate to the [Packer link](https://atlas.hashicorp.com/packer) and access the the newly build configuration that you just pushed.
- On the left side of the page access the **Variables link** and enter all the environmental variables from the **main.json** file and their corresponding values.
- Navigate back to [Builds link](https://atlas.hashicorp.com/builds) and queue a build. A successfull build results in the creation of an artifact, in this case an AWS artifact. This can be viewed from the [Artifacts Registry](https://atlas.hashicorp.com/artifacts).


### Part 2: Launching the Infrastructure & Deploying the application
- On a command line program such as Git, navigate to the directory **Zero_DownTime/ops/terraform**
- Create an environment for the infrastructure remotely on Atlas by executing the comman **terraform remote config -backend-config "name=your_atlas_username/name_of_your_environment"**
- Upload the terraform files by executing the command **terraform push -name "your_atlas_username/name_of_your_environment"**
- On your Atlas account, navigate to [Terraform Link](https://atlas.hashicorp.com/terraform) and access your newly created environment
- **Queue Plan** to plan the infrastructure and **Apply Plan** to spin up the nodes and deploy the application on AWS
