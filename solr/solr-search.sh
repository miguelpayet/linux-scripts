#!/bin/bash
curl -X POST 'Content-type:application/json' --data-binary '{"params":{"q":"limeño",
      "defType":"edismax", "qf":["nombre", "ingredientes", "descripcion"],
      "fl":"nombre,tipo,descripcion,identidad,score",
      "start":"0",
      "rows":"500",
      "sort":"tipo asc, score desc",
      "wt":"json"}}' http://solr.sdp.net.pe:8983/solr/mycol1/select
