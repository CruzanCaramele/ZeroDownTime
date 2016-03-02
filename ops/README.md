## Content

#### Packer folder

This folder contains the code of the AMI which is used as a base image for launching the infrastructure on AWS. It is written in JSON format, and Puppet is used as a provisioner and for configuration of resources. The folder comprises the following :

| File/Folder | Description |
| ------- | ----------- | 
| main.json | The AMI in JSON format |
| Puppet | Contains modules and manifests used to provision and configure the AMI. |
| Scripts | Contains simple scripts for updating and tools installation for the AMI. |



#### Terraform folder

This folder contains code for the infrastructure. The server(s) is launched on AWS using the AMI created from the Packer build as the base image. Upon launch, the application becomes available live on the www.


