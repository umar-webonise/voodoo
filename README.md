VooDoo
======

**`Voodoo`** is a Software as a Service which provides media transformation. It provides various functionalities for transformation of Images and Videos.    

Compatibility
-------------

#### Ruby

Ruby 2.0.0

#### ffmpeg

FFmpeg 2.5.3

#### Imagemagick

Imagemagick 6.9.0

#### NSQ

Nsq 0.3.0

Dependencies
------------

### [FFmpeg](https://www.ffmpeg.org) -
FFmpeg is a complete solution to record, convert and stream audio and video. It is a command line tool to convert one video file format to another. It supports various formats.

Download and install FFmpeg from the link below
https://www.ffmpeg.org/download.html

### [Imagemagick](http://www.imagemagick.org) -
It is a software suite to create, edit, compose, or convert bitmap images. It can read and write images in a variety of formats (over 100) including GIF, JPEG, PNG, etc.

Follow the instructions given in the link to install Imagemagick 
http://www.imagemagick.org/script/install-source.php


### [NSQ](http://nsq.io) -
NSQ is a realtime distributed messaging platform designed to operate at scale, handling billions of messages per day.

Follow the instructions given in the link to install Nsq
http://nsq.io/deployment/installing.html

Steps to Run Service
--------------------

Once the installation is done follow the instructions below to start voodoo service


#### Install gem dependencies 

**Run the commands if you are first time user of service**

* Install the dependencies
```
bundle install
```

#### Configurations

* Configure config/database.yml according to your database server.


* Run Migrations

```
ruby bin/migration_up.rb
```

#### Start Nsq - Run binaries in nsq-0.3.0.linux-amd64.go1.3.3

* Start **`nsqlookupd daemon`** 
```
bin/nsqlookupd
```
* Start **`nsqd daemon`**
```
bin/nsqd --lookupd-tcp-address=127.0.0.1:4160
```
* Start **`NSQ Admin`**
```
bin/nsqadmin --lookupd-http-address=127.0.0.1:4161
```


#### Start the Service

* Start **`RACK server`** on one console
```
rackup
```
* Start **`Image consumer`** on new console
```
ruby bin/image_consumer.rb
```
* Start the **`Video Consumer`** on new console
```
ruby bin/vidoe_consumer.rb
```


# Usage of Service

1. Registration for service
2. Job request for application

### Registration

To register your application with the service you will need to pass a CURL request to the service.

#### API End Point:

| Method | End-Point        | Usage                                              | Returns                                                  |
|--------|------------------|----------------------------------------------------|----------------------------------------------------------|
| POST	 | /v1/registration	| Registration of you application to voodoo service. | Access key for accessing service(API-KEY)                |

#### Registration Parameters
#### For end point /v1/registration

|Parameters| Description                                         |
|----------|-----------------------------------------------------|
|app_domain| name of the domain you want to register into service|

* Example

```ruby
{"app_domain":"encrypted.google.com"}
```
Curl Request Example.
```
curl --header "Content-Type: application/json" --data '{"app_domain":"www.google.com"}' http://localhost:9292/v1/registration
```
### Job Request

The service supports 2 types of job requests.

1. Image processing request
2. Video processing request


#### Supported operations on Images

* Crop
* Change Resolution
* Thumbnail
* Rotate
* Scale

#### Supported image formats

* .jpg/.jpeg
* .png
* .gif

#### Supported operations on Videos

* Split
* Cut
* Change the resolution
* Change the video format
* Change Video bit-rate
* Generate thumbnail

#### Supported video formats

* .mp4
* .avi
* .ogg
* .mkv
* .wav
* .mov
* .m4a
* .webm
* .flv

### API End Point:
| METHOD | End-Point        | Usage                                              | Returns                                                  |
|--------|------------------|----------------------------------------------------|----------------------------------------------------------|
| POST	 | /v1/create/job	| To submit a Job to service for process.            | Destination Url from where to collect your processed job |


#### For end point /v1/create/job
|Parameters      |Description                                                             |
|----------------|------------------------------------------------------------------------|
|api_key         | Provided at the time of registration of the your application to system.|
|source_url      | Source of the file needed to be transformed.                           |
|notification_url| URL at which you need to be notified once job is complete.             |
|actions         | list of all the transformations need to be performed on your file.     |

* Example

```ruby
 {
  "api_key": "78bd3f81a861ce84",
  "source_url": "https://encrypted.google.com/images/srpr/logo11w.png",
  "actions": 
  {
    "rotate": 180
  },
  "notification_url": "http://encrypted.google.com/notificationpath"
}
```

Curl Request Example
```
curl --header "Content-Type: application/json" --data '{"api_key":"bbeb4924d066922f", "source_url": "http://www.imagica.com/pathtomedia.jpg", "actions": {"resize": 50000, "quality": 50}, "notification_url": "http://www.imagica.com/notificationpath"}' -X POST http://localhost:9292/v1/create/job
```

References
----------

1. voodoo -
[View Documentation on GitHub](https://github.com/deepakm-webonise/voodoo/blob/master/README.md)

2. VideoConverter - 
[View Documentation](https://github.com/divya-webonise/Videoconverter/blob/master/videoconverter/README.md)

3. Webomagick -
[View Documentation]( https://github.com/deepak-webonise/webomagick/blob/master/README.md)