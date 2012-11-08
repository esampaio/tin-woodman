# Tin Woodman

![](http://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Tin_Woodman.png/200px-Tin_Woodman.png)

Tin Woodman is a robot to automatise the retrieval of service invoices generated via the [Ginfes](http://jundiai.ginfes.com.br) web app.

## Requirements

To run the program you are going to need:
- [PhantomJS](http://phantomjs.org) >= 1.7
- [CasperJS](http://casperjs.org) >= 1.0.0RC4

## Usage

First you have to edit the tin-woodman.coffeescript to add in your username and password.
Then just run:

```
casperjs tin-woodman.coffeescript <invoice number>
```
