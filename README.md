# Whipped Cream

> HTTP topping for [Raspberry Pi](http://www.raspberrypi.org)
> [![Gem Version](https://badge.fury.io/rb/whipped-cream.png)](http://badge.fury.io/rb/whipped-cream)
> [![Build Status](https://travis-ci.org/justincampbell/whipped-cream.png?branch=master)](https://travis-ci.org/justincampbell/whipped-cream)
> [![Code Climate](https://codeclimate.com/github/justincampbell/whipped-cream.png)](https://codeclimate.com/github/justincampbell/whipped-cream)

![Whipped Cream logo](header.png)

Whipped Cream is a tool which does a couple of things:

* Parses a simple plugin DSL to create web servers for Raspberry Pi I/O (input
  and output).
* Creates and tests plugins on your computer.
* Deploys plugins to your Rapsberry Pis.

It has a CLI (command line interface) command which parses a plugin:

```rb
name "Garage"

button "Open/Close", pin: 18
```

...and can start a web server:

```
$ whipped-cream start garage.rb
```

![Whipped Cream screenshot](http://f.cl.ly/items/390q221S2g3f041l0d2T/iOS%20Simulator%20Screen%20shot%20Oct%2011,%202013%207.54.56%20AM.png)

...which can be deployed to your Pi:

```bash
$ whipped-cream deploy garage.rb 192.168.1.123
...
```

## Getting Started

### Get a Pi

You'll need:

* Raspberry Pi
* Power adapter
* 4GB+ SD Card

You might also want:

* Solderless breadboard & jumper cables, for prototyping
* GPIO breakout cable ([Adafruit](http://www.adafruit.com/products/914)), for easily extending the GPIO pins to your breadboard
* Mini USB wifi adapter, for placing the Pi anywhere in your house when you're done
* A case for your Raspberry Pi

### Install Ruby on your computer

Whipped Cream runs on Ruby 1.9.3 and above.

#### Mac

We recommend [ruby-install](https://github.com/postmodern/ruby-install) for
installing Ruby versions, and [chruby](https://github.com/postmodern/chruby)
for switching between them. [RVM](http://rvm.io) will also work fine.

You can also install Ruby 2.0 with [Homebrew](http://brew.sh).

#### Windows

[RubyInstaller for Windows](http://rubyinstaller.org)

#### Linux

Most package managers have recent Ruby versions available. Try `sudo apt-get
install ruby1.9.3` or `sudo yum install ruby1.9.3`. You can also use
[ruby-install](https://github.com/postmodern/ruby-install) and
[chruby](https://github.com/postmodern/chruby).

### Install the whipped-cream CLI to your computer

That's right, we're still on your computer, not your Raspberry Pi.

`gem install whipped-cream`

### Check to make sure everything works

```bash
$ whipped-cream demo
[2013-10-11 07:59:19] INFO  WEBrick 1.3.1
[2013-10-11 07:59:19] INFO  ruby 1.9.3 (2013-06-27) [x86_64-darwin12.4.0]
[2013-10-11 07:59:19] INFO  WEBrick::HTTPServer#start: pid=5351 port=35511
```

You should now be able to point your browser to
[http://127.0.0.1:35511](http://127.0.0.1:35511) and see the demo running.

## Creating Plugins

Whipped Cream creates a web page which maps HTML controls to GPIO pins.

### Pins

You'll want to use the pin numbering from the BCM chip (not the actual pin
number, and not the WiringPi numbers).

<table>
  <tr>
    <th>Raspberry Pi Rev1</th><th>Raspberry Pi Rev2</th>
  </tr>
  <tr>
    <td><img src="http://imgur.com/Nq6sADj.png" alt="Raspberry Pi Rev1"/></td>
    <td><img src="http://imgur.com/QGoEzTi.png" alt="Raspberry Pi Rev2"/></td>
  </tr>
  <tr>
    <td colspan=2 align="center">
      Images from <a href="http://www.hobbytronics.co.uk/raspberry-pi-gpio-pinout">HobbyTronics</a>
    </td>
  </tr>
</table>

### Controls

#### Name

Gets shown at the top of the page.

```rb
name "Garage"
```

#### Switches

Toggle a pin on or off.

```rb
switch "Light", pin: 24
```

#### Buttons

Momentarily turn a pin on for 0.25 seconds.

```rb
button "Open/Close", pin: 18
```

#### Sensors

Display something on the web page based on a pin's value.

```rb
sensor "Door", high: "Closed", low: "Open", pin: 23
```

Sensors can also be created with a block to show non-pin data.

```rb
sensor "Pi Uptime" do
  system 'uptime'
end
```

## Testing

* Run the tests with `rake`
* Deploy to a Vagrant box with `rake vagrant:deploy`

## Thanks

Web UI designed by [Ashton Harris](http://ashtonharris.me).

Logo designed by [Jeff Bloch](http://www.redbubble.com/people/jabbtees).
