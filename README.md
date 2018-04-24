# stackr

This is a simple proof of concept project that allows users to upload videos
and have them converted to stacked stills. This does things like even out water
remove crowds of people and generally blur motion in shots. There are some
examples in my post [here](https://charlieegan3.com/blog/2018/04/22/bringing-photoshop-imagestacking-to-mobile-with-ffmpeg-hugin-imagemagick-hypersh).

There is a preview environment
[here](https://charlieegan3-stackr.herokuapp.com/) where you can try it out.

The project was built to give me a Photoshop-like image stacking tool that I
could use from my phone. It is built using the following tools and services:

* FFmpeg
* Hugin
* ImageMagick
* Sinatra
* Hyper.sh
* Heroku
* Pushover
* Google Cloud

## Run your own

You probably won't want to do all this but...

1. Create a storage bucket on Google Cloud
1. Create a service account with rights to edit that bucket's contents
1. Get your Hyper.sh JSON file from `~/.hyper`
1. Create an application on Pushover and get a user & app key.
1. (optional) Build the image and push it to hub.docker.com (see Makefile)
1. Create an app on Heroku and push this repo to it.
1. Set the environment variables in `.envrc.template` on Heroku.
