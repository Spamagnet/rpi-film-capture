# Bolex 18-5

These parts are from [Rob Scott's Bolex 18-5 build](http://rob.scottclan.cc/2017/07/telecine-project-part-1/). The [Bolex 18-5](http://www.bolexcollector.com/projectors/185.html) is a standard 8mm silent projector manufactured from 1961 through 1963. An upgraded model with auto-threading, the [Bolex 18-5 Auto](http://www.bolexcollector.com/projectors/185auto.html), was manufactured from 1963 through 1966.

It is a well-built projector and lends itself well to this project. 

All the models in this folder are released into the public domain under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/). See the `COPYING.txt` file for the full text of the license.

## Camera bracket
The `arducam-bracket.scad` part is a bracket with has screw holes for the Arducam. It has two slots to allow the bracket to bolted directly to the metal plate. These slots allow the distance from the camera sensor to the film place to be adjusted.

The `arducam-bracket-zoom-lens-support.scad` part also has a support for a [9-22mm CCTV zoom lens](http://a.co/6X0dezo), in order to prevent the fairly large lens from wobbling or vibrating. I'm not using this right now, due to issues with it blocking screw holes and getting in the way of lens adjustments.

## Light source holder
The `led-holder.scad` part is a cylindrical holder for the LED and diffuser that fits inside the projector lens barrel. See [part 2 of the build](http://rob.scottclan.cc/2017/07/telecine-project-part-2-camera-and-light/).

## Pulley
The `pulley.scad` part is a pulley which attaches to the NEMA 17 stepper motor and then drives the projector mechanism via a belt/O-ring. See [part 3 of the build](http://rob.scottclan.cc/2017/07/telecine-project-part-3-shutter-and-motor/).

## Power and Ethernet
The Bolex projector has two openings in its case that lend themselves well to connecting power and Ethernet. The `power-ethernet-jack-holder.scad` is a "plug" that can be placed over/in the openings and then screwed in place. Parts of it are, of course, specific to my particular build, but you can take adapt it as needed.
