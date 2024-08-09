## grafana 配置nginx代理


### grafana 配置

修改/etc/grafana/grafana.ini文件

```text
root_url = %(protocol)s://%(domain)s:%(http_port)s/grafana

# Serve Grafana from subpath specified in `root_url` setting. By default it is set to `false` for compatibility reasons.
serve_from_sub_path = true
```


### nginx 配置

这个配置与server平级。
```text
    map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
    }
```
下面配置在server内部。
```text
        location /grafana {
            proxy_set_header   Host $host:$server_port;
            proxy_redirect off;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_connect_timeout 60;
            proxy_read_timeout 600;
            proxy_send_timeout 600;
            add_header  X-Frame-Options "" ;
            proxy_pass http://192.168.1.131:3000/grafana;
        }

        location /grafana/api/live/ws {
            proxy_read_timeout 300s;
            proxy_send_timeout 300s;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            proxy_pass http://192.168.1.131:3000/grafana;
        }

```
参考文件在： nginx.example.conf