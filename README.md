# ![Whipped Cream logo](header.png)

> HTTP topping for [Raspberry Pi](http://www.raspberrypi.org)
> [![Gem Version](https://badge.fury.io/rb/whipped-cream.png)](http://badge.fury.io/rb/whipped-cream)
> [![Build Status](https://travis-ci.org/justincampbell/whipped-cream.png?branch=master)](https://travis-ci.org/justincampbell/whipped-cream)
> [![Code Climate](https://codeclimate.com/github/justincampbell/whipped-cream.png)](https://codeclimate.com/github/justincampbell/whipped-cream)

## Install

`gem install whipped-cream`

## Demo

`whipped-cream demo`

## DSL

```garage.rb
name "Garage"

button "Open/Close", pin: 18

switch "Light", pin: 23

sensor "Door", pin: 24, low: "Closed", high: "Open"
```

## Run a plugin

`whipped-cream start garage.rb`

## Deploy to a Pi

`whipped-cream deploy garage.rb 192.168.1.123`
