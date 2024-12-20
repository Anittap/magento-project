# Magento installation 

This is a set of codes used to deploy magento app on a dockerised infra. The root files in this repository contains the Dockerfile that was used to build the magento image, necessary configuration files to use inside the Dockerfile and docker-compose.yml. 

Note: After cloning, go to the directory /main and customise the terraform.tfvars and main.tf files as you wish. The EC2 instance you are using to create this infra must have the appropriate IAM permissions to create the resources.

## Creating Infrastructure

Install terraform and initiate the project using the following command
```bash
terraform init
```
Temporarly remove the resource definitions after "master-asg" from main.tf since we need to create the manager node first, initiate docker swarm and use the join token to edit the userdata files(magento.sh, setup.sh) 

Format the code using:
```
terraform fmt
```
Validate the code:
```
terraform validate
```
To Create the infra
```
terraform apply
```
Read through the changes to be made and type 'yes' to apply the changes. 
Now access the manager instance using a bastion server and initiate docker swarm
```
docker swarm init
```
Use this tocken in the usedata scripts mentioned above and re-add the codes we removed earlier. Repeat the commands to create the infra. 

## Creating docker service stack

Clone the files listed in the root directory of this repository to the manager node.

List the nodes using:
```
docker node ls
```
Set the manager node's availability as pause

```
docker node update --availability=pause manager-hostname
```
label the rest of the nodes:
```
docker node update --label-add tier=magento-worker magento-1
docker node update --label-add tier=magento-worker magento-2
docker node update --label-add tier=magento-worker magento-3
docker node update --label-add tier=magento-elasticsearch magento-es
docker node update --label-add tier=magento-mysql magento-mysql
```
Deploy the stack using
```
docker stack deploy -c docker-compose.yml magento_stack
```
Access individual magento nodes using a bastion server and run the following commands
```
docker container ls --filter "name=magento_stack_magento" --format "{{.Names}}" | while read container_name; do
  docker container exec $container_name bash -c "/usr/local/bin/php bin/magento setup:install --base-url=https://magento.anitta.cloud --db-host=\$MYSQL_HOST --db-name=\$MYSQL_DATABASE --db-user=\$MYSQL_USER --db-password=\$MYSQL_PASSWORD --admin-firstname=Admin --admin-lastname=Admin --admin-email=admin@admin.com --admin-user=admin --admin-password=Admin123* --language=en_US --currency=USD --timezone=America/Chicago --backend-frontname=admin --search-engine=elasticsearch7 --elasticsearch-host=\$ELASTICSEARCH_HOST --elasticsearch-port=9200"
done
```
```
docker container ls --filter "name=magento_stack_magento" --format "{{.Names}}" | while read container_name; do
  docker container exec $container_name bash -c "chown -R www-data:www-data /var/www/html"
done
```
