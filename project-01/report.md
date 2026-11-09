Step1: Update my Ubuntu
```
sudo apt update
lsb_release a
df -h
```
Step2:Install PostgreSQL
```
#install 
sudo apt instsll postgresql
#check the version 
psql  --version
#start postgresql
sudo systemctl start postgresql
#check the status of postgresql
sudo system status postgresql
#check the clusters
pg_lsclusters
```

Steps3: Enter PostgreSQL
```
sudo -u postgres psql
```

Step4: DB creation
refer to the file ecommerce.sql

Step5: Create script for db health check.
