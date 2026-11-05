#Problems and how did I solve them:
**Problem1**
After finished the docker-compose.yml and prometheus.yml configuration. Run the command ```docker compose up -d ``` can't access to **http://localhost:9090**, the page of Prometheus.

**Troubleshooting**
Action:
- Check the container status with ```docker ps``` , only to find Grafana and postgres-exporter container.
Run ```docker compose up -d" again, discover that while Grafana and postgres-exporter are all shown as running, the Prometheus
container only shows **Started**.

- Check all the activities with ```docker ps -a```
and found this 
```e2b3ce561495   prom/prometheus                         "/bin/prometheus --c…"   11 minutes ago   Exited (2) 2 minutes ago ```
the prometheus container was started and immediately exit.

do
```
docker container logs prometheus
```
Found

```
prometheus  | time=2026-11-02T22:44:33.672Z level=ERROR source=main.go:768 msg="Error loading config (--config.file=/etc/prometheus/prometheus.yml)" file=/etc/prometheus/prometheus.yml err="parsing YAML file /etc/prometheus/prometheus.yml: yaml: unmarshal errors:\n  line 4: field scrape_config not found in type config.plain"
```

Result:
There is a typo in the prometheus.yml file of the field scrape_config, it should be --> scrape_configs. Correct it. Restart the container, not work, check the log again and found there is an indentation error. Correct it and run the container again. Sucessfully access to the Prometheus.



**Problem2**:
When creating the Grafana dashboard panels, can't find the PromQLs that I 
need for monitoring the DB situation except the pg\_up.
Can't find pg\_stat\_activity\_count,pg\_database\_size\_bytes, pg\_stat\_database\_deadlocks, etc.

**Troubleshooting**:
1. Check if exporter exposed these indicators.
Action:
```curl -s http://localhost:9187/metrics | grep pg_stat_activity_count
```
Result:
Empty Output --> exporter didn't manage to export these indicators.

2. Check the right the monitor account.
Action:
Rechacked the role pg\_monitor, assigned with pg\_read\_all\_stats right.

Result:
Still no indicators exported.


3. Check if used the right DB user for the database login.
Action:
- Recheck the docker-compose.yml file and discovered the environment line for configuring 
the login user is missing.
- Add this line with the correct account and login info.(Here didn't use 
Docker secrets, but using Docker secrets is better)

Result:

