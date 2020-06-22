#!/bin/bash
sleep 180
echo airflow_db_host: $1 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
echo airflow_db_user: $2 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
echo airflow_db_password: $3 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
echo airflow_db_name: $4 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
echo airflow_db_port: $5 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
echo elasticache_endpoint : $8 >> ansible/roles/ansible-role-airflow/defaults/main/main.yml
export ANSIBLE_HOST_KEY_CHECKING=False
echo [airflow] >> ansible/inventory.ini
echo $6 ansible_ssh_private_key_file=$7 ansible_ssh_user=ec2-user >> ansible/inventory.ini
ansible-playbook -i ansible/inventory.ini ansible/airflow.yml

