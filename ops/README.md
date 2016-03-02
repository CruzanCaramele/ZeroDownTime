## Content

#### Packer folder

This folder contains the code of the AMI which is used as a base image for launching the infrastructure on AWS. It is written in JSON format, and Puppet is used as a provisioner and for configuration of resources. The folder comprises the following :

| File/Folder | Description |
| ------- | ----------- | 
| main.json | The AMI in JSON format |
| Puppet | Contains modules and manifests used to provision and configure the AMI. |
| Scripts | Contains simple scripts for updating and tools installation for the AMI. |
