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

### Requirements
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