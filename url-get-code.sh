#!/bin/bash


url_valid(){
  url=$1
  curl -L --write-out "%{http_code}\n" --silent --output /dev/null --head --fail "$url"
}
 

page=$1
url_valid "$page"


