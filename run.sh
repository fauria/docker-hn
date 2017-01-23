#!/bin/bash

# Create directory structure:
mkdir -p www/logs
mkdir -p www/news/profile
mkdir -p www/news/story
mkdir -p www/news/vote
mkdir -p www/tmp

# Set site attributes and color:
sed -ie "s/http:\/\/news.yourdomain.com\//$(echo $SITE_URL|sed -e 's/[\/&]/\\&/g')/g" lib/news.arc
sed -ie "s/http:\/\/www.yourdomain.com/$(echo $PARENT_URL|sed -e 's/[\/&]/\\&/g')/g" lib/news.arc
sed -ie "s/My Forum/$(echo $SITE_NAME|sed -e 's/[\/&]/\\&/g')/g" lib/news.arc
sed -ie "s/What this site is about./$(echo $SITE_DESCRIPTION|sed -e 's/[\/&]/\\&/g')/g" lib/news.arc
sed -ie "s/favicon-url\*  \"\"/favicon-url\*  \"$(echo $FAVICON_URL|sed -e 's/[\/&]/\\&/g')\"/g" lib/news.arc
sed -ie "s/color 180 180 180/color $((16#${RGB_COLOR:0:2})) $((16#${RGB_COLOR:2:2})) $((16#${RGB_COLOR:4:2}))/g" lib/news.arc

# If defined and not pressent, add Google Analytics tracking code:
ga_line=$(grep 'pr ga' lib/news.arc|wc -l)
if [[ $GA_CODE != 'disabled' && $ga_line -lt 1 ]]; then
  sed -e "s/UA-XXXXXXXX-1/$GA_CODE/g" ga.arc >> lib/news.arc
  sed -ie '/pr votejs/a (tag script (pr ga*))' lib/news.arc
fi

if [ ! -f www/admins ]; then
   echo $ADMIN_USER > www/admins
fi

# Copy static assets:
if [ $(ls static|wc -l) -eq 0 ]; then
   cp -ri static-copy/* static
fi

chown -R bin:root /anarki

. run-news
