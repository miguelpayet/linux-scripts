curl -X POST http://localhost:8983/solr/mycol1/dataimport \
  -H 'Accept-Encoding: gzip, deflate, br' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: http://localhost:8983' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -d 'command=full-import&clean=true&commit=true&wt=json&indent=true&verbose=false&optimize=false&debug=false'
