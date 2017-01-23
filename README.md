fauria/hn
=========

![docker_logo](https://raw.githubusercontent.com/fauria/docker-hn/master/docker_139x115.png)![docker_fauria_logo](https://raw.githubusercontent.com/fauria/docker-hn/master/docker_fauria_161x115.png)

Roll your own [Hacker News](http://news.ycombinator.com) clone with this Docker image.

It is based on [Anarki](https://github.com/arclanguage/anarki), a publicly modifiable 'wiki-like' fork of [Arc Lisp](http://www.paulgraham.com/arc.html).

It allows the customization of the following features:

* Site and parent site URLs
* Site name and description
* Color
* Favicon
* Admin user
* Google Analytics code

Installation from [Docker registry hub](https://registry.hub.docker.com/u/fauria/hn/).
----

You can download the image using the following command:

```bash
docker pull fauria/hn
```


Environment variables
----

The customization of the HN clone is done through the following environment variables:

* Variable name: `SITE_NAME`
* Default value: "My Forum"
* Accepted values: Any string.
* Description: Sets the site name, displayed in the top bar and used as the page title.

----

* Variable name: `SITE_DESCRIPTION`
* Default value: "What this site is about."
* Accepted values: Any string.
* Description: Sets the description of the site.

----

* Variable name: `SITE_URL`
* Default value: "http://news.example.com"
* Accepted values: Public URL of the site.
* Description: Sets is the main URL of the site.

----

* Variable name: `PARENT_URL`
* Default value: "http://www.example.com"
* Accepted values: Any URL.
* Description: Sets is the URL of the parent site, linked through the logo on the top bar. If there is no parent site, use the same value as in `SITE_URL`.

----

* Variable name: `ADMIN_USER`
* Default value: "admin"
* Accepted values: Any valid username.
* Description: Username of the admin user. After launching your site, register an account with that username to get admin privileges.

----

* Variable name: `RGB_COLOR`
* Default value: "B4B4B4"
* Accepted values: Any RGB color expressed in hexadecimal, without hash.
* Description: Sets the color for the top bar. Grey by default.

----

* Variable name: `FAVICON_URL`
* Default value: "/arc.png"
* Accepted values: Any path or URL.
* Description: Location of the favicon. By default, it uses the same file as the logo.

----

* Variable name: `GA_CODE`
* Default value: "disabled"
* Accepted values: A Google Analytics tracking code, such as *UA-12345678-9*
* Description: If specified, adds a Google Analytics tracking code to the site.

----

Exposed port and volumes
----

The image exposes port `8080` and exports two volumes:

* `/anarki/static`: Static files such as images. `UID`: 0, `GID`: 2.
* `/anarki/www`: User generated content and logs. `UID`: 0, `GID`: 2.

Use cases
----

#### Create a temporary container for testing purposes:

```
docker run -i -t --rm -e SITE_URL="http://127.0.0.1/" -e PARENT_URL="http://127.0.0.1/" -p 80:8080 fauria/hn
```

#### Create a production container, such as [KeyDao](https://keydao.com):

```
docker run -e RGB_COLOR="649afa" -e ADMIN_USER=fauria -e SITE_NAME="KeyDao" -e SITE_DESCRIPTION="BlockChain news aggregator" -e SITE_URL="https://keydao.com/" -e PARENT_URL="https://keydao.com/" -e GA_CODE="UA-87936404-1" -p $COREOS_PRIVATE_IPV4:8080 -v /srv/keydao/www:/anarki/www -v /srv/keydao/static:/anarki/static -d --restart=always --name keydao fauria/hn
```

*Note: This container is intended to be used behind a proxy such as Nginx.*
