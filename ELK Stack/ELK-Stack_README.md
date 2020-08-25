## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below;

[Diagram of the Virtual Azure Environment](https://drive.google.com/file/d/1F6Owu1kfAbLom1ybzgAjYDTiqUF1E0K-/view?usp=sharing)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the .YML file may be used to install only certain pieces of it, such as Filebeat.

  - [Install-ELK.YML](https://raw.githubusercontent.com/zbrafi/machine-learning/master/ELK%20Stack/Playbooks/Ansible_Playbooks_config.yml?token=APBHLTLS6IZZPYEWELAJRP27ISBNY)
  - [Ansible-Playbook_config.YML](https://raw.githubusercontent.com/zbrafi/machine-learning/master/ELK%20Stack/Playbooks/Ansible_Playbooks_config.yml?token=APBHLTLQF45DIEI52LQT5427ISB4C)
  - [Filebeat-Playbook.YML](https://raw.githubusercontent.com/zbrafi/machine-learning/master/ELK%20Stack/Playbooks/Filebeat-playbook.yml?token=APBHLTPO3ZUN33TSYCCJSNC7ISB2C)
  - [Metricbeat-Playbook.YML](https://raw.githubusercontent.com/zbrafi/machine-learning/master/ELK%20Stack/Playbooks/Metricbeat-playbook.yml?token=APBHLTMSEPJENIP3XG2EG5S7ISB5Q)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound traffic to the network.
- The load balancer can lower the risk of DDoS attach. The off-loading function of a load balancer defends an organization against distributed denial-of-service (DDoS) attacks. It does this by shifting attack traffic from the corporate server to a public cloud provider.
- The load balancer helps servers move data efficiently, optimizes the use of application delivery resources and prevents server overloads.
- Jump-box provides another secure layer to help defend your network. An advantage of having a jump box is to prevent all the VM's to be exposed to the public. This help us better manage the logs and monitor the traffic and always keep us informed on who is accessing our internal network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an agent on your servers, Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash. Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server which can be reviewed at a later point.

The configuration details of each machine may be found below;

| Name       | Function | IP Address | Operating System |
|------------|----------|------------|------------------|
| Jump Box   | Gateway  | 10.0.0.5   | Linux 18.04-LTS  |
| Web-1      | DVWA     | 10.0.0.4   | Linux 18.04-LTS  |
| Web-2      | DVWA     | 10.0.0.8   | Linux 18.04-LTS  |
| Web-3      | DVWA     | 10.0.0.7   | Linux 18.04-LTS  |
| DVWA-4     | DVWA     | 10.0.0.9   | Linux 18.04-LTS  |
| DVWA-5     | DVWA     | 10.0.0.10  | Linux 18.04-LTS  |
| ELK-Server | ELK      | 10.1.0.4   | Linux 18.04-LTS  |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Jump-Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 71.79.133.44

Machines within the network can only be accessed via Ansible container using a SSH connections on the Jump-Box.
- The only machine able to connect to the ELK Server is the Jump-Box with an IP address of 104.42.155.65.

A summary of the access policies in place can be found in the table below;

| Name       | Publicly Accessible | Allowed IP Addresses |
|------------|---------------------|----------------------|
| Jump Box   | No                  | 71.79.133.44         |
| Web-1      | No                  | 10.0.0.5             |
| Web-2      | No                  | 10.0.0.5             |
| Web-3      | No                  | 10.0.0.5             |
| DVWA-4     | No                  | 10.0.0.5             |
| DVWA-5     | No                  | 10.0.0.5             |
| ELK-Server | No                  | 10.0.0.5             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because, Automating the configuration with Ansible provides us with an easier reconfiguration in case of a loss. It also help us manage and perform multiple configuration at a time saving us time and resources.

The playbook implements the following tasks: (more details can be found in the playbook folder)
- Install docker.io
- Install pip3
- Increase virtual memory
- Use more memory
- Download and launch elk container

[install-ELK.png](https://github.com/zbrafi/machine-learning/blob/master/ELK%20Stack/Diagrams/Setup%20Diagrams/install-ELK.png)

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[docker_ps.png](https://github.com/zbrafi/machine-learning/blob/master/ELK%20Stack/Diagrams/Setup%20Diagrams/docker-ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name   | Function | IP Address | Operating System |
|--------|----------|------------|------------------|
| Web-1  | DVWA     | 10.0.0.4   | Linux 18.04-LTS  |
| Web-2  | DVWA     | 10.0.0.8   | Linux 18.04-LTS  |
| Web-3  | DVWA     | 10.0.0.7   | Linux 18.04-LTS  |
| DVWA-4 | DVWA     | 10.0.0.9   | Linux 18.04-LTS  |
| DVWA-5 | DVWA     | 10.0.0.10  | Linux 18.04-LTS  |

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat collects monitoring data from your Filebeat instance and sends it directly to your monitoring cluster. Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server which can be reviewed at a later point.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Create the playbook by using nano and use the extension .YML
- Update the ansible configuration file to include user account you will be using
- Update the Ansible host file with the IP address of the machines you will like to run the playbook on
- Run the playbook, and navigate to server to check that the installation worked as expected.

- The files with the label .yml are playbooks. For Filebeat we will be using filebeat-playbook.yml. You copy it to the Ansible folder within /etc/ansible

- Ansible host file, where you will add the host IP of the machine which you will be running the playbook on. Each playbook contains a header with the host name, the selected playbook will only run on the host name entered within the playbook. In order to run the playbook on multiple group os machines, the host file can be adjusted.E.g.

[webserver]
10.0.0.4
10.0.0.8

[ELK]
10.1.0.4

-  ELK server can be accessed by : http://52.255.198.176:5601/app/kibana

Commands the user will need to run to download the playbook, update the files, etc.

- download the playbook: curl [web address of the playbook]
- create/ edit a playbook: nano [playbook name] e.g. nano elk-server-playbook.yml
- run the playbook: ansible-playbook [playbook name] e.g. ansible-playbook elk-server-playbook.yml
