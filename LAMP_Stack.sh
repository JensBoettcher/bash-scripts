#!/bin/bash

#ANCHOR - used variable section
read -p "Please enter a resource-group name: " resource_group
read -p "Please enter a name for your vm: " vm_name
read -p "Please enter a name for the admin user-account: " admin_user
nsg_name=$vm_name"NSG"

#ANCHOR - create a resource group
az group create \
    --name $resource_group \
    --location germanywestcentral

#ANCHOR - create a ubuntu 22.04 vm
az vm create \
    --resource-group lamp-group \
    --name $vm_name \
    --image Ubuntu2204 \
    --generate-ssh-keys \
    --public-ip-sku Standard \
    --admin-username $admin_user \
    --verbose

#ANCHOR - create nsg rule to open ssh port 22
az network nsg rule create \
    --resource-group $resource_group \
    --nsg-name $nsg_name \
    --name AllowSSH \
    --protocol Tcp \
    --direction Inbound \
    --priority 100 \
    --source-address-prefix "*" \
    --source-port-range "*" \
    --destination-address-prefix "*" \
    --destination-port-ranges 22 \
    --access Allow

#ANCHOR - create nsg rule to open HTTP port 22
az network nsg rule create \
    --resource-group $resource_group \
    --nsg-name $nsg_name \
    --name AllowHTTP \
    --protocol Tcp \
    --direction Inbound \
    --priority 150 \
    --source-address-prefix "*" \
    --source-port-range "*" \
    --destination-address-prefix "*" \
    --destination-port-ranges 80 \
    --access Allow

#ANCHOR - wait for vm deploy
while [ "$(az vm show \
    --resource-group $resource_group \
    --name $vm_name \
    --query "provisioningState" \
    --output \
    tsv)" != "Succeeded" ];
do
    sleep 10
done


#ANCHOR - show public ip
public_ip=$(az vm show \
    --resource-group $resource_group \
    --name $vm_name \
    --show-details \
    --query "publicIps" \
    --output tsv)

#ANCHOR - vm connect and manual fingerprint query
ssh -i /home/ifrit1983/.ssh/id_rsa $admin_user@$public_ip << EOF
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 
sudo apt install mysql-server 
sudo apt install php libapache2-mod-php php-mysql
sudo systemctl restart
EOF

#ANCHOR - this line prevent the fingerprint query, it's not enabled by default, delete the # below and set the # above)
#NOTE - I do not recommend it for security reasons
#ssh -o StrictHostKeyChecking=accept-new -i /home/ifrit1983/.ssh/id_rsa $admin_user@$public_ip << EOF
#sudo apt update
#sudo apt upgrade -y
#sudo apt install -y apache2 
#sudo apt install mysql-server 
#sudo apt install php libapache2-mod-php php-mysql
#sudo systemctl restart
#EOF

#ANCHOR - connect with the vm
ssh -i /home/ifrit1983/.ssh/id_rsa $admin_user@$public_ip