# step1: pg_dump
```
creat back up file
sudo -u postgres pg_dump ecommerce \
-Fc \
-f ~/dba-portfolio/project-02/backup/ecommerce.backup

ls -lh ~/dba-portfolio/project-02/backup/ecommerce.backup
```

# step2: Database recovery
```
sudo -u postgres createdb ecommerce_restore

sudo -u postgres pg_restore \
-d ecommerce_restore \
~/dba-portfolio/project-02/backup/ecommerce.backup

sudo -u postgres psql ecommerce_restore
```

# step3

```






