FROM ubuntu:16.04
MAINTAINER Fer Uria <fauria@gmail.com>

ENV SITE_NAME "My Forum"
ENV SITE_DESCRIPTION "What this site is about."
ENV SITE_URL "http://news.example.com"
ENV PARENT_URL "http://www.example.com"
ENV FAVICON_URL "/arc.png"
ENV ADMIN_USER admin
ENV RGB_COLOR B4B4B4

ENV GA_CODE disabled

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git mercurial racket rlwrap dma
RUN git clone http://github.com/arclanguage/anarki
COPY run.sh /anarki
COPY ga.arc /anarki

WORKDIR /anarki
RUN hg clone https://bitbucket.org/zck/unit-test.arc
RUN bash arc.sh tests.arc

# Copy static assets to later export:
RUN cp -r static static-copy
RUN chmod +x run.sh

VOLUME /anarki/static
VOLUME /anarki/www

EXPOSE 8080
CMD ["/anarki/run.sh"]
