# Automated ElkStack Deployment

The files in this repository were used to configure the network depicted below.

https://drive.google.com/file/d/1fFNbnXBWv_F4mLoJTJjQz4_FFVOPRUlc/view?usp=sharing

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  ---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

    # Use apt module
    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    # Use pip module (It will default to pip3)
    - name: Install Docker module
      pip:
        name: docker
        state: present

    # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044


      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting Traffic to the network.
Load balancers protect your Network's availability and Web Traffic/Secuirity. By using the Jumpbox Virtual machine we are capable of automation of the Network seccurity, by separating the vulnerable Virtual Machines(VMs) with Network Segmentation we will use Access Control to restrict the Network traffic that accesses these VMs.

Integrating an ELK server also allows users to easily monitor the vulnerable VMs for changes to the data and system logs. We will install beats on this server to monitor system logs and record data from pentesting we will do on these VMs.
Filebeat watches for changes in the System Logs.
Metricbeat is used to record system performance logs.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
|   Web1   |     Web Server     |       10.0.0.5     |         Linux         |
| Web2    |     Web Server     |     10.0.0.6       |         Linux         |
| Elk Server     |   Elk Server       |      10.1.0.4/104.45.215.3      |         Linux         |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
#Add whitelisted IP addresses_73.176.8.245

Machines within the network can only be accessed by MyHome PC and Jumpbox Provisioner.
The VM we allowed access to our ELK VM was the Jumpbox Provisioner located at IP 40.121.68.30
A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No              | 73.176.8.245    |
|   Web1    |        No             |     10.0.0.4        |
|      Web2    |         No            |        10.0.0.4              |
|  ElkServer  |  No  ||  40.121.68.30  |



### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because Ansible allows you to batch large tasks into one playbook. This helps when configuring multiple machines at once to simplify your processes. You can tailor the playbook to the machines specific needs.

The playbook implements the following tasks:
The playbook installs Docker.io onto the new machine
The playbook downloads and installs the python language that will be used to run the programs specified.
Uses Pip3 to install the Docker Module
Download and install a Docker Elk Container that runs on the Specified Ports
Increases the Total memory of the VM
Ensures Docker is running on restarts

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
![Docker on Elk](https://user-images.githubusercontent.com/82415281/133950524-ba7cab1b-1ebc-4443-8486-9f7c2968455a.PNG)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web1: 10.0.0.5
Web2: 10.0.0.6

We have installed the following Beats on these machines:
Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
Filebeat logs system information. This allows your system’s functions to be monitored and the information to be forwarded for further analysis. 
Metricbeat monitors system performance. It monitors the system CPU, memory and load, among other things and displays the performance data to the user.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

FOR ELK CONFIGURATION
Copy the install-elk.yml file to the Container.
- Update the install-elk.yml file to include the selected  services, applications, and installations you would like it to run on the Elkserver
- Run the playbook using ansible-playbook install-elk.yml to install elk on the selected virtual machine.

FOR FILEBEAT CONFIGURATION
Copy the filebeat-config.yml file to the container using the curl command: curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml
Copy the Filebeat config file to /etc/filebeat/filebeat-playbook.yml
Use Kibana to help install most recent version of filebeat for linux
Update the Config file with our Specified IP addresses
Edit/Run the Filebeat Playbook using ansible-playbook filebeat-playbook.yml to install filebeat onto the selected virtual Machine
/etc/ansible/roles/filebeat-playbook.yml. /etc/filebeat/filebeat-playbook.yml
/etc/ansible/filebeat-config.yml. By specifying the IP addresses of the Elk Machine in the Config file.
http://104.45.215.3:5601/app/kibana#/home
FOR METRICBEAT CONFIGURATION
Copy the metricbeat-config.yml file to the container from the Resources to /etc/ansible/
Navigate to http://104.45.215.3:5601/app/kibana to access the latest Linux Installation of Metricbeat.
Update the Config file with our Specified IP addresses
Edit/Run the Metricbeat Playbook using ansible-playbook metricbeat-playbook.yml to install filebeat onto the selected virtual Machine
/etc/ansible/metricbeat-playbook.yml. /etc/metricbeat/metricbeat-playbook.yml
/etc/ansible/metricbeat-config.yml. By Specifying the IP addresses of the Elk Machine in the Config File.
http://104.45.215.3:5601/app/kibana#/home
The Following Screenshots are from the Daily ElkStack Week Activities
![Project1day1Screenshot](https://user-images.githubusercontent.com/82415281/133950571-66035191-2ce8-4d3e-bdf6-ed5ea77e05a0.PNG)
![Project1day2Screenshot1](https://user-images.githubusercontent.com/82415281/133950597-57723a8c-1816-4814-9f37-8549227aaa69.PNG)
![Project1day2Screenshot2](https://user-images.githubusercontent.com/82415281/133950602-8546c05d-85c0-4856-a6fa-a6ebb7d51f11.PNG)
