#!/bin/bash
curl -v -X POST 'Content-type:application/json' --data-binary '{"params":{"q":"solr",
      "defType":"edismax", "qf":["titulo", "handle", "descripcion", "tags"],
      "fl":"titulo,handle,identry,descripcion,score",
      "start":"0",
      "rows":"500",
      "sort":"score desc",
      "wt":"json"}}' http://solr.sdp.net.pe:8983/solr/mycol1_blog/select
