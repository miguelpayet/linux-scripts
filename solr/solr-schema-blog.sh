#!/bin/bash
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"identry",
     "type":"string",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"handle",
     "type":"text_es",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"titulo",
     "type":"text_es",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema
     
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"descripcion",
     "type":"text_es",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"tags",
     "type":"text_es",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema
     
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"tag",
     "type":"text_es",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"idtag",
     "type":"string",
     "stored":true }
     }' http://localhost:8983/solr/mycol1_blog/schema
     
