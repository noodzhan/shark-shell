#!/bin/bash

resp=$(curl 'http://1.15.231.74:7500/api/proxy/tcp' \
  -H 'Accept: */*' \
  -H 'Accept-Language: zh-CN,zh;q=0.9' \
  -H 'Authorization: Basic YWRtaW46bm9vZHpoYW5AMTIzNA==' \
  -H 'Connection: keep-alive' \
  -H 'Referer: http://1.15.231.74:7500/static/' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  --compressed \
  --insecure --connect-timeout 30)

# echo $resp

if [[ $(echo $resp | grep "offline" | wc -l) -gt 0 ]]; then
  ## sudo apt install mailutils
  echo $resp | iconv -t utf-8 | mail -s "frp-alter" noodzhan@163.com
fi
