This LAMP stack bash script requires only 4 inputs.
1. you must log into your azure subscription
2. you must enter your resource group name (Azure policies must be consider)
3. your vm name must be entered (Azure policies must be consider)
4. and you need a admin-user-name (Azure policies must also be consider)

After you’ve entered all the necessary information, the script will run fully automated through the bash script. It will end up logged in on the VM and you can start configuring your Ubuntu 22.04 LTS server with Apache2, MySQL, and PHP.

!!!The fingerprint query for the SSH connection will be automatically accepted. I’ve only done this for bash script testing. I would never do this in daily business.!!!"
