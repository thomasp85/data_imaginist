---
title: "Rapture"
description: "Herein I describe the provenance of the Rapture series, my though process, and some technical details about how it is made."
large_thumb: yes
img:
  thumb: assets/images/rapture_0.png
---

![Rapture \#0](/assets/images/rapture_0.png)

Welcome to the Rapture! This site gives an overview of my generative art series *Rapture* which was released on [ArtBlocks](https://artblocks.io/project/141) on August 23rd as a series of 1000 unique pieces from the same algorithm. Here, I will talk a bit about the history of Rapture, my thoughts on the project as a whole, as well as some of the technical details of how the pieces are created. In the end there will also be information about how to order prints if you are the owner of a Rapture piece.

## Where it started

Rapture is the culmination of work that began back in 2019 as I was taking up generative art again after a hiatus. The first piece from this work was genesis112:

![genesis112](https://www.data-imaginist.com/art/005_genesis/genesis112_hu940eda6aa68a41b4b0a8e759d476cd8d_143478_0x1000_resize_box_2.png "genesis112")

Following this came a string of pieces in the genesis series where I explored different aspects of this flow and the rendering technique that came with it. After genesis I developed the technique further with phases, where the flow was now considered a border between two fluids, mixing together. While the rendering and some of the calculations where different, the flow was intact:

![phases705](https://www.data-imaginist.com/art/006_phases/phases705_hu248415ca3909e719104e1fbf6b6627e2_102556_0x1000_resize_box_2.png "phases705")

The same type of flow can also be seen in both the storms and prism series, but with some very different rendering techniques:

![![prism11](https://www.data-imaginist.com/art/009_prism/prism11_hu15289d2f1463b5da795637ea5a2d64b3_23591896_0x1000_resize_box_2.png "prism11")storms3118](https://www.data-imaginist.com/art/007_storms/storms3118_hub2dbdbce8d1d82a484ac168016d906aa_1838520_0x1000_resize_box_2.png "storms3118")

![prism11](https://www.data-imaginist.com/art/009_prism/prism11_hu15289d2f1463b5da795637ea5a2d64b3_23591896_0x1000_resize_box_2.png "prism11")

While I've created a lot of series not incorporating this flow type, I seem to always get back to it.

Rapture is my definitive version of this. As such, it reaches all the way back to genesis and takes most of its visual cues from that early work, but within it are ideas and improvements from the last 2 years of working with the flow in one form or another.

The first piece saved from what ended up being the Rapture algorithm shows the lineage much stronger than the final pieces:

![Rapture: Early render](/assets/images/rapture_first_save.png "Rapture: Early render")

This is a very clear successor to genesis338 in everything but the color choice:

![genesis338](https://www.data-imaginist.com/art/005_genesis/genesis338_hu19fc60717d90451585acb0fb6a565bcb_106689_0x1000_resize_box_2.png "genesis338")

In the end I abandoned the idea of doing a full-on genesis tribute for this project, a choice I'm very happy with now.

## What was I thinking

When creating an algorithm that needs to create a 1000 uncurated pieces of high quality it forces you to think a lot about the choices you make in your code. For me it also forced me to think about the series as a whole and what overarching feeling I wanted to convey. With Rapture I've created a narrative around the pieces. Each piece shows a magical seal, which has burst as it failed to contain all the power within it. All the feature variations are related to this narrative and describes things like the allegiance and type of the seals, as well as the types of power it holds within. For the visual side I've been very inspired by religious iconography. I wanted each piece to be something that could be hung in a fictional temple celebrating its powers. The color and tone is quite inspired by glass mosaics in christian churches, especially the visually lucid ones from the Gothic period. In Rapture the 6 main colors symbolizes different crystals that the seal draws power from. There are no predefined palettes so the quest for finding 6 distinct colors I could trust to combine in any way and in different tone variations was long and hard. I'm very happy with the result.

The rendering techniques used in Rapture is the most diverse yet for this flow. While the basic version may look a bit like what was seen in genesis, it is an improved version based on experiences from the prism series. Accompanying the "genesis" render type are 5 completely new ways to render the flow. Some of these are obvious and some more involved. I'm super happy with the diversity these 6 different basic rendering techniques brings to the project as a whole as they imbue a very specific and unique feel to their pieces.

## Technicalities

In the above we have talked a lot above a specific "flow"; well, what is that all about? At its core it is a flow field (a function that provides a displacement vector for every point in space) based on curling of noise. Curl is a mathematical operation on fields that basically describe the rotation of fixed spheres as they are subjected to a certain flow (yikes). Consider a flow field based on perlin noise. At every given position you calculate 2 noise values based on two different seeded perlin noises and use those values as the directional vector of the flow at that point. If you were to submerge a sphere into this flow and keep it fixed in space, it would begin to rotate around its fix point (its center). Curl is simply a way to mathematically figure out the nature of this rotation for every point in space.

Why all the fuzz about this - there are easier ways to get some flow, right? True, but curl comes with a lot of benefits. If we go back to the example with a field described by two perlin noises, and set a bunch of particles loose in that, we would observe that they would all coalesce in some well defined troughs. While this is interesting in and of itself, this is usually not how we expect fluid flow to behave. You don't drip blue dye into a glass of water and expect it to swirl around and then concentrate itself in a few places, after all. Curl solves all this by mathematically promising us a flow that is non-compressible, meaning that the density of particles will remain more or less even as they are moved around by the flow. Non-compressability is one of the core traits of how fluids behave, and the idea of using curl noise as a cheap simulation of fluid behavior [earned the inventor an Oscar](https://www.cs.ubc.ca/news/2015/02/robert-bridson-earns-sci-tech-oscar-bringing-real-world-simulations-hollywood).

So, I obviously didn't invent this. However, I do think I have battle tested it in generative art more than most. I love the curly flow that it gives, the small vortexes with their empty centers, and the long rivers that drifts off here and there. Still, calculating the flow is just one thing, how to draw it is another. The basic idea that comes from the genesis series is to have a high-detail polygon (e.g. if you have a rectangle you add a lot of points along the straight sides), and then subject each of the vertices to the flow, again and again. You collect all the intermediary results along the way. Further, after every iteration you figure out if some neighbor vertices have drifted apart too much and then inserts new vertices between them to constantly keep a high level of detail at every point of the flow. The last part is central to the smooth look of the flow, but is also a point of danger because the number of vertices can explode as the polygon gets more and more deformed. Because of this I cap the final number of vertices in Rapture because it can otherwise end up prohibitively heavy to compute.

The border flow is special in the sense that I don't insert any vertices as I deform the polygon. This creates these draped shapes of long straight parts and parts of high variation that gives a nice tension to the more natural flow of the seal.

When it comes to rendering the deformed polygons the way it was done in the genesis series was to simply draw them as thin lines, starting from the most deformed (this is a very important part of the look and why progressive rendering of this is not possible). For Rapture, the same look (*Tranquil*) is achieved by drawing polygons instead, defined by the two adjacent deformations. This solves an issue in the original approach where areas of high turbulence would have gaps in the flow. The old approach is kept in one of the alternate rendering approaches (*Oscillating*) but not every stage is rendered, resulting in clearly defined lines that create beautiful interference patterns. The Erratic and *Lively* renders are two different approaches to the same idea. For both, points along the B-spline defined by the polygon vertices is sampled and drawn, jittering the color a bit along the way. *Lively* is drawn simply using small circles of various size, and Erratic is drawn as small segments perpendicular to the B-spline. In the *Curious* rendering each vertex is drawn as a circle which results in lines tracing the exact movement of the vertex through the flow. *Faceted* is probably the "wildest" of them all - it is drawn by cutting out tiles between deformation stages and drawing these with a jittered color. This rendering technique ended up only looking good with the *Circular* flow type so it is one of the few hard-coded constraints in the system.

## Printing

If you are the owner of a Rapture piece you are eligible to order a signed print of it. Only one print per piece will be made, so if you bought the piece on secondary make sure to check the list below to see if the print for your piece has already been claimed. Prints will be offered in A2 size. For square Rapture pieces this translates to 420mm/16.5" on both sides. For portrait and landscape Rapture pieces this translates to 420x594mm/16.5x23.4". If you are the type of person that care about paper (I salute you), then I can tell that the pieces will be printed on Hahnemüehle Fine Art Baryta Satin.

Prints will be US$ 250 plus shipping and can be ordered by sending a mail to [thomasp85@gmail.com](mailto:thomasp85@gmail.com). Upon ordering I will need to verify that you are in fact the owner of the piece.

### Completed prints

- [#9](https://artblocks.io/token/14100009)
- [#97](https://artblocks.io/token/141000097)
- [#187](https://artblocks.io/token/141000187)
- [#195](https://artblocks.io/token/141000195)
- [#214](https://artblocks.io/token/141000214)
- [#215](https://artblocks.io/token/141000215)
- [#239](https://artblocks.io/token/141000239)
- [#262](https://artblocks.io/token/141000262)
- [#322](https://artblocks.io/token/141000322)
- [#361](https://artblocks.io/token/141000361)
- [#377](https://artblocks.io/token/141000377)
- [#391](https://artblocks.io/token/141000391)
- [#420](https://artblocks.io/token/141000420)
- [#472](https://artblocks.io/token/141000472)
- [#518](https://artblocks.io/token/141000518)
- [#571](https://artblocks.io/token/141000571)
- [#576](https://artblocks.io/token/141000576)
- [#579](https://artblocks.io/token/141000579)
- [#592](https://artblocks.io/token/141000592)
- [#606](https://artblocks.io/token/141000606)
- [#652](https://artblocks.io/token/141000652)
- [#672](https://artblocks.io/token/141000672)
- [#673](https://artblocks.io/token/141000673)
- [#754](https://artblocks.io/token/141000754)
- [#794](https://artblocks.io/token/141000794)
