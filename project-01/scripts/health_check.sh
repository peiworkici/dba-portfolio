#!/bin/bash
echo "===== PostgreSQL Health Check ====="
echo "Checking PostgreSQL service..."
sudo systemctl is-active postgresql
echo "Checking disk space..."
df -h
echo "Checking memory..."
free -h
echo "Checking PostgreSQL clusters..."
pg_lsclusters
echo "===== Health Check Completed ====="
