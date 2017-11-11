# google-cloud-dl

Deep Learning setup on Google Cloud

## Getting Started

These instructions will help you run deeplearning applications on Theano using Keras.

### Prerequisites

Should have [Google Clould](https://cloud.google.com/) account

### Setup

* Create a new project

    Click on the three dots shown in the image below and then click on the + sign to create a new project.

* Create a VM instance

    Click on the three lines on the upper left corner, then on the compute option, click on ‘Compute Engine’
    Now click on ‘Create new instance’. Name your instance, select zone as ‘ us-west1-b’. Choose your ‘machine type’. (I chose 8v              CPUs).

    Select your boot disk as ‘Ubuntu 16.04 LTS’. Under the firewall options tick both ‘http’ and ‘https’ (very important). Then,    choose the disk tab and untick ‘ Delete boot disk when instance is deleted’. 
    If you click on ‘customize’, you will be able to find options for using GPUs. You can choose between 2 NVIDIA GPUs.
    Check both "Allow HTTP traffic" and "Allow HTTPS traffic"

    Now click on ‘Create’
* Make external IP address as static

    By default, the external IP address is dynamic and we need to make it static to make our life easier. Click on the three    horizontal lines on top left and then under networking, click on VPC network and then External IP addresses.

* Change the Firewall setting

    Now, click on the ‘Firewall rules’ setting under Networking.
    Under protocols and ports you can choose any port. I have chosen tcp:5000 as my port number. Now click on the save button.

* Start your VM instance

    Now start your VM instance. When you see the green tick click on SSH. This will open a command window and now you are inside  the VM.

* Finally run the script "gcp-setup.sh" and you are good to go.

#### NOTE: If python not running on Anaconda,try :
``` export PATH=~/anaconda2/bin:$PATH ```

