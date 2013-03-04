# Tin Woodman

![](http://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Tin_Woodman.png/200px-Tin_Woodman.png)

Tin Woodman is a robot to automate the retrieval of service invoices generated via the [Ginfes](http://jundiai.ginfes.com.br) web app.

## Requirements

To run the program you are going to need:
- [PhantomJS](http://phantomjs.org) >= 1.7
- [Ruby](http://ruby-lang.org) >= 1.9.3
- [Redis](http://redis.io) >= 2.4.17

## Usage

First you have to edit the tin-woodman.coffeescript to add in your username and password.
After that you need to install the bundler gem:

```
gem install bundler
```

And run:

```
bundle install
```

This will install the rake and resque gems.

To enqueue a file to be downloaded, just run:

```
rake "enqueue[XX]"
```

Where XX is the number of the service invoice you wish to download.
You may also enqueue a range of service invoices by running:

```
rake "enqueue[XX,YY]"
```

After you've enqueued the invoices you wish to download, you may start 6
workers by running:

```
rake run
```
Whenever the command fails, use the one in *Rakefile*:

```
BACKGROUND=yes TERM_CHILD=1 COUNT=6 QUEUE=file_download rake resque:workers
```

They'll immediately start downloading the enqueued invoices and saving them to
the *./xmls* directory.
You can monitor the workers and queue via the resque web interface by running;

```
resque-web
```

And then accessing http://127.0.0.1:5678
