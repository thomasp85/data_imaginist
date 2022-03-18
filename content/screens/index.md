---
title: "Screens"
description: "Screens is a generative art series released on ArtBlocks curated. This page will contain information, background, and updates on the series."
date: '2022-01-31'
large_thumb: yes
img:
  thumb: assets/images/screens/header.jpg
editor_options: 
  markdown: 
    wrap: 80
---

Screens is a generative series that launched on ArtBlocks Curated on January
31st 2022. This page contain additional information and background about the
project. To buy a Screens piece, use a secondary market site such as
[OpenSea](https://opensea.io/collection/screens-by-thomas-lin-pedersen)

<iframe allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="100%" sandbox="allow-scripts" src="https://generator.artblocks.io/255000000" width="80%" style="min-height: 500px; margin-left: 10%">

</iframe>

<a href="https://www.artblocks.io/token/255000000" style="margin-left: 25%;"><i>Screens #0</i></a>

### Additional ressources

-   [Screens Layers](https://www.data-imaginist.com/screenslayer) --- Experience
    the build-up of a random Screens piece from the collection.
-   [Screens Surfer](https://www.data-imaginist.com/screensurfer) --- Browse
    ephemeral, out-of-band, Screens piece.
-   [Screens Scaler](https://www.data-imaginist.com/screenscaler) --- Experience
    your favourite Screens piece at different scales, uncovering what lies
    outside of the frame.

## Background

Screens is the continuation of an idea and vision that started with my
Constructive series (released in August 2021). The primal aim was to explore the
aesthetics offered by silk screen printing techniques, and this naturally led me
to explore the poster prints from both Bauhaus artists and Russian
constructivism artists. Thus, while working on Constructive, the focal points
where strong geometric compositions, strong simple colour palettes, gradients
using a rendering technique mimicking screen printing.

<img src="assets/images/constructive11.jpg" width="50%" style="width:50%; margin-left:25%;" alt="constructive 11">
<a href="https://foundation.app/@thomasp85/foundation/72856" style="margin-left: 25%;"><i>Constructive 11</i></a>

Constructive was very much a handheld series. While it is generative in nature,
the macro composition was decided beforehand. I did enjoy the result immensely
and I knew almost immediately that I wanted to explore this aesthetic in a long
form format. Thus began the thought process that led to Screens.

With Screens I wanted to continue my main focus: Strong geometric shapes and
gradients together with the signature grainy rendering style. However, the
approach taken with Constructive wasn't scalable and besides, I didn't want to
rehash a finished project.

The idea of extruding lines into screen-like shapes and drawing them in an
isometric view first came together with the idea of using flow fields to
generate the lines. I very quickly cast aside the idea of flow fields for
several reasons, one being overexposure to the concept, and one being a strong
affection for pure geometric shapes in this project. The basic idea was born
though, and could easily be used with other things than flow fields.

All of this happened without any coding or sketching at all. This is pretty much
on par with my process, as I often design and develop ideas purely in my head.
Then, when I finally decided to sit down and code, the central part of the
system was completed in 2 days, mainly because the result matched my vision so
well (this is not always the case). However, following this came several months
of trying out ideas and fine tuning the algorithm. In order for Screens to work
as long form generative art I had to embrace a level of chaotic behaviour that I
would usually refrain from putting out there beyond my control. Thus, an
enormous amount of work was put into keeping the chaos in check so that I could
rest assured that every piece would work. Most of this work, and the months that
went into it, is obviously not visible since it was concerned with what
shouldn't come up. If the work done is not apparent I have succeeded.

## The System

Screens, being a series generative artworks, is of course based on some system,
some rules, that control how things are made. While I've strived to make Screens
something that can be appreciated in itself without knowing anything about the
system (or even know that a system exists) I do believe that it may interest
some to look down in the engine room. You may do this out of curiosity, or for
understanding the collection better as a whole. This section will dive into a
no-code description of the system, both describing the rendering, as well as how
the composition is made and what the different features encode.

### Rendering

The rendering engine in screens is created to mimic how a silk screen print
comes to life. Each piece is made up of a set of discrete colours and for each
colour a monochrome template is generated with smooth gradients. The template
then gets converted to an (almost) pure black and white image by changing the
smooth gradients to the grainy noise that Screens is known for. After this has
been done, the black parts of the template is coloured with the colour of the
screen and the template is then merged into a master image.

<img src="assets/images/screens/process.png" width="100%" style="width:100%;" alt="The making of #923">

<img src="assets/images/screens/255000923.jpeg" width="50%" style="width:50%; margin-left:25%;" alt="Screens #923">
<a href="https://www.artblocks.io/token/255000923" style="margin-left: 25%;"><i>Screens #923 --- finale</i></a>

I had to make some concessions as to how close I could follow the print making
technique, mostly when it comes to the alignment shifts. The first iteration was
true to its heritage in that the templates was generated perfectly and the
misalignments was only added when the template was merged with the master.
However, being based on pixels, rotating and moving the template after
generation resulted in noticeable quality degradation. Because of this the
misalignment was performed when the template was generated to ensure each pixel
had the exact grayscale value it should.

The order each template is applied in are not random. Each palette is ordered
roughly by increasing darkness. This was done partly to follow how you would
generally apply paint, since lighter colours have a harder time covering up
darker colours. Pixels do not have this issue of course, but I felt it made
sense to keep this order. A nice and unplanned side-effect of this choice is
that the build-up of the piece becomes much more suspenseful because the final
piece tends to get more and more structure with each subsequent addition of
templates.

### Composition

At its core, Screens is a bunch of lines extruded into screens in the
y-direction and drawn with a random colour gradient applied to them. There is
obviously a bit more to it, so lets talk about that, starting how the lines are
made.

#### Actors

Lines are not drawn at random --- they have some structure to them. This
structure is provided by the concept of *actors* which provides geometric
direction to a set of screens that will thus follow the same rules. How these
actors are combined to make up the final structure is defined by the style (see
*Scenes* below). There are 5 types of actors available to choose from:

##### Circular actor

This actor creates screens as circle arcs at different radii from the same
randomly selected center. Arcs are created by randomly selecting a radius, a
start angle, and a span measured in radians. The radius selected *can* be biased
towards lower values giving a denser look. Otherwise it is uniformly distributed
between the minimal and maximal radius allowed. Since the span of the screens
are based on radians it follows that screens farther from the center tend to be
longer than those closer to it.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000266.jpeg" alt="Screens #266">
<a href="https://www.artblocks.io/token/255000266"><i>Screens #266</i></a>
</div>
<div>
<img src="assets/images/screens/255000207.jpeg" alt="Screens #207">  
<a href="https://www.artblocks.io/token/255000207"><i>Screens #207</i></a>
</div>
</div>

##### Square actor

This actor is in many ways equal to the circular actor except the screens
follows the circumference of a square rather than a circle. It has the same
possibility of becoming condensed by biasing the distance to the center towards
lower values. It also follow the same rule as the circular actor in terms of
screens farther from the center being longer in general. This is because the
span is given as a percentage of the circumference of the square at the given
distance from the center. The square actor is the only one capable of creating
sharp turns in its screens, giving it some unique compositional abilities.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000716.jpeg" alt="Screens #716">
<a href="https://www.artblocks.io/token/255000716"><i>Screens #716</i></a>
</div>
<div>
<img src="assets/images/screens/255000521.jpeg" alt="Screens #521">  
<a href="https://www.artblocks.io/token/255000521"><i>Screens #521</i></a>
</div>
</div>

##### Radial actor

The radial actor is one of the more versatile of the five. It creates screens
that radiates from a randomly selected center. The start distance and angle
relative to the center is chosen at random. All screens from the same radial
actor follows the same rotational momentum, but this momentum can vary between
different radial actors, giving rise to both strongly winding spirals and almost
straight lines from the center. While screens from the same radial actor cannot
cross each other, they have the potential to get very near to each other.
Because of this each screen is terminated if it gets within a threshold distance
to other screens from the same actor.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000230.jpeg" alt="Screens #230">
<a href="https://www.artblocks.io/token/255000230"><i>Screens #230</i></a>
</div>
<div>
<img src="assets/images/screens/255000423.jpeg" alt="Screens #423">  
<a href="https://www.artblocks.io/token/255000423"><i>Screens #423</i></a>
</div>
</div>

##### Straight actors

This actor is probably the simplest, but has the possibility of creating the
some of the strongest clean composition. Further, due to it's simplicity it
works well in unison with other actors where it creates interest without overly
complicating the composition. The screens from the straight actor all follow the
same angle and is distributed along a shared line. Like circle and square
actors, the screens from a straight actor can be condensed around the shared
line or uniformly distributed out to a max distance from the line.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000380.jpeg" alt="Screens #380">
<a href="https://www.artblocks.io/token/255000380"><i>Screens #380</i></a>
</div>
<div>
<img src="assets/images/screens/255000078.jpeg" alt="Screens #78">  
<a href="https://www.artblocks.io/token/255000078"><i>Screens #78</i></a>
</div>
</div>

##### Spline actors

This actor sets up 4 or 5 parallel lines that acts as control points for a
clamped open B-spline. Each screen is based on a location along the control
point lines, e.g. a screen placed at 0.25 would derive its control points a
quarter along the lines. Further, it has a start and end from 0 to 1 (B-splines
are parameterised between 0 and 1). As with radials, Spline screens has the
potential to get very close to each other so they also check for and terminate
at too close proximity to other screens. Spline actors are the only actors
capable of creating screens with a more wavy feel and the possibility of
changing directions multiple times. This offers some unique possibilities in
composition.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000613.jpeg" alt="Screens #613">
<a href="https://www.artblocks.io/token/255000613"><i>Screens #613</i></a>
</div>
<div>
<img src="assets/images/screens/255000983.jpeg" alt="Screens #983">  
<a href="https://www.artblocks.io/token/255000983"><i>Screens #983</i></a>
</div>
</div>

#### Scenes

The actors define how screens are created - the scenes defines which actors are
used and in what capacity.

##### Hero

Potentially the most easily recognised scene. It consist of a single actor
placed inside the frame creating 100 screens. Because a single actor cannot
create intersecting screens the hero scene has a very clean and striking look.
However, there is also not much room for emergent compositional traits to arise.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000921.jpeg" alt="Screens #921">
<a href="https://www.artblocks.io/token/255000921"><i>Screens #921</i></a>
</div>
<div>
<img src="assets/images/screens/255000395.jpeg" alt="Screens #395">  
<a href="https://www.artblocks.io/token/255000395"><i>Screens #395</i></a>
</div>
</div>

##### Collapse

Like hero, the collapse scene only consist of a single actor type. However, it
contains 50 of these actors placed both inside and outside the frame, each
giving rise to a single screen. Because of the ensuing chaos this scene is the
one with the highest potential for unique emergent compositions and quite a few
of my own personal favourites are of this style. The reason why this approach
refrain from resulting in pure chaos is that each screen shares a common
dynamic, thus unifying them in the same compositional harmony.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000086.jpeg" alt="Screens #86">
<a href="https://www.artblocks.io/token/255000086"><i>Screens #86</i></a>
</div>
<div>
<img src="assets/images/screens/255000473.jpeg" alt="Screens #473">  
<a href="https://www.artblocks.io/token/255000473"><i>Screens #473</i></a>
</div>
</div>

##### Company

Company is the last of the scenes only using a single actor type. It consist of
two of the same actors, placed inside or outside the frame and each creating 50
screens. This style is often one of both harmony and strong geometries, though
certain setups can of course create dissonance.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000999.jpeg" alt="Screens #999">
<a href="https://www.artblocks.io/token/255000999"><i>Screens #999</i></a>
</div>
<div>
<img src="assets/images/screens/255000315.jpeg" alt="Screens #315">  
<a href="https://www.artblocks.io/token/255000315"><i>Screens #315</i></a>
</div>
</div>

##### Antagonists

This is like company but with two different actors instead of two identical
ones. While the name implies tension, that is not always the case. The
combination of e.g. a circular and straight actor might just give rise to a some
of the interest that the cleanness of a hero lack.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000843.jpeg" alt="Screens #843">
<a href="https://www.artblocks.io/token/255000843"><i>Screens #843</i></a>
</div>
<div>
<img src="assets/images/screens/255000701.jpeg" alt="Screens #701">  
<a href="https://www.artblocks.io/token/255000701"><i>Screens #701</i></a>
</div>
</div>

##### Crowd

The crowd scene consist of three actors, two of which are of the same type. Each
of these gives rise to 30 screens Once you up the number of actors to three
there is a high probability that things end up dense and chaotic. The harmonics
of the two actors of the same type somewhat works to counteract the chaos, but
the last actor is bound to throw a wrench into the effort. Thus this style will
often balance between harmony and tension.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000680.jpeg" alt="Screens #680">
<a href="https://www.artblocks.io/token/255000680"><i>Screens #680</i></a>
</div>
<div>
<img src="assets/images/screens/255000445.jpeg" alt="Screens #445">  
<a href="https://www.artblocks.io/token/255000445"><i>Screens #445</i></a>
</div>
</div>

##### Order and Chaos

The last scene style consist of 3 actors emanating 30 screens, just like the
crowd style. However, this time all 3 actors are of different types. It follows
that any type of harmony is generally only obtained through chance and that
chaos is the name of the game. Remember that chaos is not used derogatory, but
simply to describe the feeling the composition elicit in the viewer. Screens has
been designed to encompass this diversity in emotional responses to the
compositions --- an overabundance of harmony quickly becomes boring.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000408.jpeg" alt="Screens #408">
<a href="https://www.artblocks.io/token/255000408"><i>Screens #408</i></a>
</div>
<div>
<img src="assets/images/screens/255000014.jpeg" alt="Screens #14">  
<a href="https://www.artblocks.io/token/255000014"><i>Screens #14</i></a>
</div>
</div>

#### Interactions

With the exception of the hero style screens are bound to intersect (I guess it
is theoretically possible for other styles to not have any intersections but
I've yet to see it). These intersection are what gives rise to the diversity of
forms, dynamics, and negative space in screens. However, intersections are not
treated evenly by all screens pieces, and how they are treated have a huge
effect on the feel of the final piece. The behaviour is encoded in the
*Clipping* trait.

##### Spacious

Spacious is very much the "standard" look of screens. For every intersection of
two screens one of them is clipped at random and segment around the cut is
removed in order to leave some distance to the intersection point and properly
separate the two resulting screens from each other. This approach ups the amount
of screens considerably thus giving rise to more variation and visual
interaction. However, due to the buffer zone around each intersection, it
retains a level of order --- no two screens are too close to each other.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000889.jpeg" alt="Screens #889">
<a href="https://www.artblocks.io/token/255000889"><i>Screens #889</i></a>
</div>
<div>
<img src="assets/images/screens/255000865.jpeg" alt="Screens #865">  
<a href="https://www.artblocks.io/token/255000865"><i>Screens #865</i></a>
</div>
</div>

##### Tight

Very much the antithesis to spacious. Here intersecting screens are kept as is
(not mentioning the work done to make the intersection point look neat). This
all have two effects: First, the lack of any cutting means that the final piece
will contain longer screens in general resulting in longer gradient; Second, the
fact that screens are touching naturally creates more visual tension and often
end up resulting in an aggressive piece, especially if the screens are stroked.
The longer gradients possible here means that screens can end up only showing a
single colour in the visible area, thus creating much more potential for
interesting negative space to form.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000498.jpeg" alt="Screens #498">
<a href="https://www.artblocks.io/token/255000498"><i>Screens #498</i></a>
</div>
<div>
<img src="assets/images/screens/255000374.jpeg" alt="Screens #374">  
<a href="https://www.artblocks.io/token/255000374"><i>Screens #374</i></a>
</div>
</div>

##### Dominating

Dominating might seem like a variation of spacious but it's effect can be
massive. Like with spacious, intersections are clipped and a buffer zone is
applied. However, with dominating a single actor is selected to always "win" in
the battle of who gets clipped. This means that screens from a single actor is
left intact while the remaining screens fight it out. It is natural that the
dominating actor ends up, ahem, dominating the piece.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000876.jpeg" alt="Screens #876">
<a href="https://www.artblocks.io/token/255000876"><i>Screens #876</i></a>
</div>
<div>
<img src="assets/images/screens/255000348.jpeg" alt="Screens #348">  
<a href="https://www.artblocks.io/token/255000348"><i>Screens #348</i></a>
</div>
</div>

#### Screen types

The last trait having a strong direct impact on the composition is the height of
the screens. The concept is pretty simple and encodes how far downwards the line
is extruded to make a screen.

##### Tall

Tall screens are basically extruded to infinity making sure that nothing behind
them will ever be visible. This is the prevalent look and the setting that most
often leads to harmonious and dense compositions.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000901.jpeg" alt="Screens #901">
<a href="https://www.artblocks.io/token/255000901"><i>Screens #901</i></a>
</div>
<div>
<img src="assets/images/screens/255000795.jpeg" alt="Screens #795">  
<a href="https://www.artblocks.io/token/255000795"><i>Screens #795</i></a>
</div>
</div>

##### Medium

Medium screens are just tall enough that they often times look tall, but thin
enough that there is often a couple of places where you get to see underneath
the screen and what is behind it. This leaves room for the solid background
colour to shiny through giving rise to interesting negative spaces and shapes
that would otherwise not be possible.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000989.jpeg" alt="Screens #989">
<a href="https://www.artblocks.io/token/255000989"><i>Screens #989</i></a>
</div>
<div>
<img src="assets/images/screens/255000654.jpeg" alt="Screens #654">  
<a href="https://www.artblocks.io/token/255000654"><i>Screens #654</i></a>
</div>
</div>

##### Thin

Thin screens are, well, thin. So thin in fact that often the resulting
composition is dominated be the background and the negative space.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000016.jpeg" alt="Screens #16">
<a href="https://www.artblocks.io/token/255000016"><i>Screens #16</i></a>
</div>
<div>
<img src="assets/images/screens/255000642.jpeg" alt="Screens #642">  
<a href="https://www.artblocks.io/token/255000642"><i>Screens #642</i></a>
</div>
</div>

##### Varied

With the varied trait one actor will get tall screens while the remaining actors
will get screens ranging from thin to medium. The effect is that instead of the
background being visible underneath the screens you'll see the structure of the
tall screens. Visually you often get the feeling of seeing the thinner screens
floating in between the infinitely tall screens.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000961.jpeg" alt="Screens #961">
<a href="https://www.artblocks.io/token/255000961"><i>Screens #961</i></a>
</div>
<div>
<img src="assets/images/screens/255000859.jpeg" alt="Screens #859">  
<a href="https://www.artblocks.io/token/255000859"><i>Screens #859</i></a>
</div>
</div>

### Colour

Colours are a big part of Screens. They are used to imbue emotions, of course,
but also as a compositional tool because screens may visually merge if they
overlap while sharing the same colour. This effect gives rise to some of the
best emergent features in the series.

#### Palettes

The colour palettes define the set of colours a piece *can* choose from.
However, it does not dictate that all colours must be used, nor how. Still, the
palettes imbue certain emotion and feels that will transfer to the final piece.
I do not want to transfer my own emotional responses to these colours to others
(more than I've done by naming them), as I believe in the observer creating
their own narratives of a piece. Thus, below are simply a few representative
pieces for each palette, showing their range:

##### Berlin

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000545.jpeg" alt="Screens #545">
<a href="https://www.artblocks.io/token/255000545"><i>Screens #545</i></a>
</div>
<div>
<img src="assets/images/screens/255000976.jpeg" alt="Screens #976">  
<a href="https://www.artblocks.io/token/255000976"><i>Screens #976</i></a>
</div>
</div>

##### Autumn

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000571.jpeg" alt="Screens #571">
<a href="https://www.artblocks.io/token/255000571"><i>Screens #571</i></a>
</div>
<div>
<img src="assets/images/screens/255000333.jpeg" alt="Screens #333">  
<a href="https://www.artblocks.io/token/255000333"><i>Screens #333</i></a>
</div>
</div>

##### Rythm

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000765.jpeg" alt="Screens #765">
<a href="https://www.artblocks.io/token/255000765"><i>Screens #765</i></a>
</div>
<div>
<img src="assets/images/screens/255000603.jpeg" alt="Screens #603">  
<a href="https://www.artblocks.io/token/255000603"><i>Screens #603</i></a>
</div>
</div>

##### Bauhaus

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000822.jpeg" alt="Screens #822">
<a href="https://www.artblocks.io/token/255000822"><i>Screens #822</i></a>
</div>
<div>
<img src="assets/images/screens/255000771.jpeg" alt="Screens #771">  
<a href="https://www.artblocks.io/token/255000771"><i>Screens #771</i></a>
</div>
</div>

##### The Avenue

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000454.jpeg" alt="Screens #454">
<a href="https://www.artblocks.io/token/255000454"><i>Screens #454</i></a>
</div>
<div>
<img src="assets/images/screens/255000087.jpeg" alt="Screens #87">  
<a href="https://www.artblocks.io/token/255000087"><i>Screens #87</i></a>
</div>
</div>

##### Iceland

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000192.jpeg" alt="Screens #192">
<a href="https://www.artblocks.io/token/255000192"><i>Screens #192</i></a>
</div>
<div>
<img src="assets/images/screens/255000290.jpeg" alt="Screens #290">  
<a href="https://www.artblocks.io/token/255000290"><i>Screens #290</i></a>
</div>
</div>

##### The Refuge

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000957.jpeg" alt="Screens #957">
<a href="https://www.artblocks.io/token/255000957"><i>Screens #957</i></a>
</div>
<div>
<img src="assets/images/screens/255000544.jpeg" alt="Screens #544">  
<a href="https://www.artblocks.io/token/255000544"><i>Screens #544</i></a>
</div>
</div>

##### Somebody that I used to love

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000947.jpeg" alt="Screens #947">
<a href="https://www.artblocks.io/token/255000947"><i>Screens #947</i></a>
</div>
<div>
<img src="assets/images/screens/255000700.jpeg" alt="Screens #700">  
<a href="https://www.artblocks.io/token/255000700"><i>Screens #700</i></a>
</div>
</div>

##### Rhino

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000249.jpeg" alt="Screens #249">
<a href="https://www.artblocks.io/token/255000249"><i>Screens #249</i></a>
</div>
<div>
<img src="assets/images/screens/255000941.jpeg" alt="Screens #941">  
<a href="https://www.artblocks.io/token/255000941"><i>Screens #941</i></a>
</div>
</div>

##### Penguin

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000199.jpeg" alt="Screens #199">
<a href="https://www.artblocks.io/token/255000199"><i>Screens #199</i></a>
</div>
<div>
<img src="assets/images/screens/255000141.jpeg" alt="Screens #141">  
<a href="https://www.artblocks.io/token/255000141"><i>Screens #141</i></a>
</div>
</div>

##### The Jungle

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000609.jpeg" alt="Screens #609">
<a href="https://www.artblocks.io/token/255000609"><i>Screens #609</i></a>
</div>
<div>
<img src="assets/images/screens/255000251.jpeg" alt="Screens #251">  
<a href="https://www.artblocks.io/token/255000251"><i>Screens #251</i></a>
</div>
</div>

##### Stencil

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000261.jpeg" alt="Screens #261">
<a href="https://www.artblocks.io/token/255000261"><i>Screens #261</i></a>
</div>
<div>
<img src="assets/images/screens/255000756.jpeg" alt="Screens #756">  
<a href="https://www.artblocks.io/token/255000756"><i>Screens #756</i></a>
</div>
</div>

##### இڿڰۣ-ڰۣ--- (Rose)

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000543.jpeg" alt="Screens #543">
<a href="https://www.artblocks.io/token/255000543"><i>Screens #543</i></a>
</div>
<div>
<img src="assets/images/screens/255000298.jpeg" alt="Screens #298">  
<a href="https://www.artblocks.io/token/255000298"><i>Screens #298</i></a>
</div>
</div>

##### Dreams of a Distant Memory

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000538.jpeg" alt="Screens #538">
<a href="https://www.artblocks.io/token/255000538"><i>Screens #538</i></a>
</div>
<div>
<img src="assets/images/screens/255000299.jpeg" alt="Screens #299">  
<a href="https://www.artblocks.io/token/255000299"><i>Screens #299</i></a>
</div>
</div>

#### Colouring scheme

While the palette sets the stage, the colouring scheme defines the feel. While
the different styles doesn't scream at you they do carry an enormous weight in
terms of the composition of the final piece.

##### Chaotic

This is the "everything goes" version. For each side of each screen two colours
from the palette are chosen at random which defines the gradient. The result is
definitely the busiest of all the colour schemes, especially when combined with
primary colour palettes such as Bauhaus.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000937.jpeg" alt="Screens #937">
<a href="https://www.artblocks.io/token/255000937"><i>Screens #937</i></a>
</div>
<div>
<img src="assets/images/screens/255000058.jpeg" alt="Screens #58">  
<a href="https://www.artblocks.io/token/255000058"><i>Screens #58</i></a>
</div>
</div>

##### Condensed

Here, every actor gets a colour assigned from the middle range of the palette
(that is, every colour except for the lightest and darkest). Each side of each
screen then randomly selects to colours from the assigned colour + light and
dark. This creates very well defined actors, bringing more structure to the
piece.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000827.jpeg" alt="Screens #827">
<a href="https://www.artblocks.io/token/255000827"><i>Screens #827</i></a>
</div>
<div>
<img src="assets/images/screens/255000695.jpeg" alt="Screens #695">  
<a href="https://www.artblocks.io/token/255000695"><i>Screens #695</i></a>
</div>
</div>

##### Gradient

Gradient works kind of like Condensed, but instead of getting a colour assigned
based on which actor the screen emanates from, it gets a colour assigned based
on its position along the y-axis. As with condensed, it create structure, but
the structure comes from proximity, not from the actor, thus creating groupings
between otherwise unrelated screens.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000825.jpeg" alt="Screens #825">
<a href="https://www.artblocks.io/token/255000825"><i>Screens #825</i></a>
</div>
<div>
<img src="assets/images/screens/255000720.jpeg" alt="Screens #720">  
<a href="https://www.artblocks.io/token/255000720"><i>Screens #720</i></a>
</div>
</div>

##### Calm

This colourway is probably not one you would notice... It's like a more
cool-headed chaotic. Like chaotic, each side of each screen is assigned 2
colours at random, with the single constraint that the two colours must be
adjacent in the palette. Since all palettes are sorted roughly by darkness it
means that all gradients in the piece ends up being very calm and low-contrast,
resulting in an overall less aggressive vibe.

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 40px; margin: 20px">
<div>
<img src="assets/images/screens/255000806.jpeg" alt="Screens #806">
<a href="https://www.artblocks.io/token/255000806"><i>Screens #806</i></a>
</div>
<div>
<img src="assets/images/screens/255000181.jpeg" alt="Screens #181">  
<a href="https://www.artblocks.io/token/255000181"><i>Screens #181</i></a>
</div>
</div>

### Wait, somethings not right...

After reading this you might find yourself browsing the collection for specific
traits to get to know them better and you may stumble upon something that
doesn't quite fit... A Crowd with only 2 actors, a chaotic style with colours
missing --- you name it. The truth is that not everything is under my control.
Things get drawn both inside and outside the frame and while everything
influences the end result, it might not be apparent how or when said influence
happens.

Take the case of #957 - the space station.

<img src="assets/images/screens/255000957.jpeg" width="50%" style="width:50%; margin-left:25%;" alt="Screens #957">
<a href="https://www.artblocks.io/token/255000957" style="margin-left: 25%;"><i>Screens #957</i></a>

Classic hero, right? Wrong! In reality it is an antagonists... We can see this
if we zoom out:

<img src="assets/images/screens/255000957_zoom.jpeg" width="50%" style="width:50%; margin-left:25%;" alt="Screens #957 - Zoomed">
<a href="https://www.artblocks.io/token/255000957" style="margin-left: 25%;"><i>Screens #957 --- Zoomed out</i></a>

This is what happens if an artist gives into and embraces chaos. So is 957 a
hero or antagonists? Who cares... The traits in Screens are more about the
potential in piece than hard truths about the outcome. Browse and use them with
a healthy dose complacency as to their importance. Knowing *about* the traits in
Screens can certainly help you understand and contextualise a piece, but they
will never capture the essence.

## The Details

Having gotten a good grip on the system itself you may be wondering how it has
all been put together. This section is for you. I will try to describe, without
showing any code, how a Screens piece is constructed, from the placement of the
screens, to the layering etc.

This section is not in any way necessary for appreciating the series, but if you
are the curious type then you'll get the most detailed description of the inner
workings of the system (until someone reverse-engineers it and writes something
better).

### Screen generation

As discussed above, all screens are the result of 5 different actors that can be
present or absent in a piece. The screens are generated one segment at a time
with a segment length of 1. The length is of course arbitrary, but keeping it at
unit length means that a lot of code can be trimmed down. For reference the
viewport that the screens are drawn into is 100x141. Each actor is only
responsible for making sure that its own screens aren't placed too close to each
other. For circular, square, and straight actors this is done by only allowing
the start position (radius for circles, half-width for squares, distance to
central line for straight) to lie at integer values (1, 2, 3, 4, ...). Once a
screen is placed that distance is no longer allowed. For b-spline and radial
actors it is a bit different because the minimum distance between two screens
can vary based on position and we can't just rely and well-defined start
positions. Thus, for these actors the screens are checked continuously against
the current pool of screens as it grows and is terminated if it comes too close.

This rule has several benefits. It means that I don't have to worry about
intersections between screens from the same actor, it ensures a nice dispersed
feel to the screens without feeling too ordered, and it removes some annoying
artefacts in my rendering engine that couldn't deal well with segments from
different screens being too close to each other (reminiscent of
[z-fighting](https://en.wikipedia.org/wiki/Z-fighting)).

Drawing segments of circles, lines, squares, even b-splines, are not that hard
and I won't bore you with the details. The end result is that we end up with a
bunch of segments of length 1. Some of these are connected in the ends and some
are not. These segments are stored as a linked list meaning that I can traverse
each screen while also being allowed to sort the pool of screens as I see fit.

But, back to where we are. We now have a bunch of lines, soon to become screens.
Let's have a look at the current situation:

<img src="assets/images/screens/segments_1.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens segments - raw">

Pretty boring, right? Well, we are only just getting started. Once we have all
those lines we need to cut them (at least for the majority of pieces). This
involves first and foremost figuring out which segments intersect with each
other. Classic implementations of this problem uses a sweep-line algorithm to
avoid comparing everything against everything, but I was a bit too lazy to be so
sophisticated. In the end I made a pseudo sweep-line implementation where I
sorted all segments along one axis based on it's lowest end point and then
compared each segment with the segments following. I then terminated the
comparisons when the highest end of the first segment was below the lowest end
of the next segment. This is pretty simple, code-wise, and fast enough for
Screens (and Memories of Qilin 🙂) which is kind of the sweet spot for getting
short code for ArtBlocks.

After the intersections have been detected one of the intersecting segments will
be removed. Then the area around the cut will get pruned (meaning that the
neighboring segments to the removed one is also removed). Lastly I remove
screens that has become too short due to all the cutting and pruning. This is
how it progresses:

<div style="display:grid; grid-template-columns: 1fr 1fr 1fr; grid-gap: 10px; margin: 20px">
<div>
<img src="assets/images/screens/segments_2a.png" alt="Screens clipping">
<i>Cutting at intersections</i>
</div>
<div>
<img src="assets/images/screens/segments_2b.png" alt="Screens pruning">
<i>Pruning around cut</i>
</div>
<div>
<img src="assets/images/screens/segments_2c.png" alt="Screens cleaning">
<i>Removing short screens</i>
</div>
</div>

The last part left is to rotate the lines slightly around the x-axis, tilting
them slightly into the picture plane, giving the characteristic isometric
perspective. The effect is very slight, but it basically compress everything a
bit along the y-axis.

<img src="assets/images/screens/segments_3.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens segments - rotated">

Now, up until this point we have only worked with line segments, and we are now
ready to convert these to the screens we all know and love. This is quite simple
as all it requires is to extrude the line downwards according to the height of
the screen. That is, we make a copy of the line segment, move it downwards and
connect the two segments into a parallelogram. Doing that, we get:

<img src="assets/images/screens/segments_4.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens segments - extruded, no fill">

which is hardly what we expected. This look is largely due to the fact that we
are simply drawing the outline of each screen, and all the screens outside the
viewport are showing themselves because nothing is occluding them. If we fill
all screens with white we can remove this:

<img src="assets/images/screens/segments_5.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens segments - extruded, filled">

Hmm... it's still not right. It doesn't resemble our pattern at all. The reason
is that we are drawing each segment in the order it is created - not based on
its location in space. Intuitively we want to draw the segments farthest away
first so that they get correctly occluded by segments in front of them. While
this seems simple in theory, sorting segments in a way so that no segment
overlaps a segment coming after it is not trivial. In some cases it is fine just
sorting by e.g. the lowest y-value in the segment, but it can easily break down
when segments get close to each other. Consider each of these three examples.
There is no single consistent way to sort all of them correctly by comparing the
coordinates of the end points:

<img src="assets/images/screens/sort issues.png" width="90%" style="width:90%; margin-left:5%;" alt="segment sorting issues">

What we are dealing with is a 2D version of how to figure out a drawing order of
triangles in 3D space so that those closest by is always drawn last. As you can
imagine, this problem was pretty important for 3D games and I was inspired by
the approach taken by John Carmack in the original Doom game, namely that of
binary space partition (BSP) trees. In the simplest form, I take a root segment,
and divide all other segments based on which side of the line supporting the
root segment it lies. I then recursively do that until I have a binary tree.
This tree can now be sorted based on which child lies on the visible or
invisible side of their root line based on a given vantage point and you end up
with a draw order:

<img src="assets/images/screens/segments_6.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens segments - sorted">

We have now arrived at our destination in terms of figuring out the screens...
on to the colors!

### A splash of color

Colors are a big part of the screens series --- both because the different
palettes adds so much ambiance to the piece (hardly unique to Screens), but also
because the coloring is integral to the rendering since it defines the layers.
We already saw in the section on [rendering](#rendering) that each color is
rendered as a black and white layer, which then gets converted into color as it
is applied to the master image. The rendering of this layer is without much
fanfare. Each screen is assigned two colors for each of its sides. When
rendering a layer for a specific color we look at which side of the small
segment faces us and chose the two colors corresponding to that side. Then, if
we are currently rendering a color not present in the two colors we paint it
white. If the current colour matches the lightest of the two we paint it black.
Lastly, if it matches the darkest of the two we paint it a shade of grey
relative to the segments location along the screen. The end result for our
current example is:

<img src="assets/images/screens/layers.png" width="100%" style="width:100%; margin-left:0%;" alt="Screens layers">

If we were to use these directly we would get this...

<img src="assets/images/screens/final_no_texture.png" width="50%" style="width:50%; margin-left:25%;" alt="Screens no texture">

Now, while this is fun to look at it is just soo boring compared to the textured
version, so how do we get there?

### Texturing like a pro

The texture in screens is arguable the reason the whole series exists. While
Screens is hardly *just* about texture, I started to design it because I wanted
a venue for the texture in a long form format, having played with it in a more
hand-held fashion in my Constructive series. So, what is this texture?

It leans heavily into how you would apply blue-noise dithering. This type of
dithering uses a blue noise texture of the same size as your image (if you don't
know what blue noise it, just think of it as a fancier cousin of white noise)
and for each pixel checks whether the source image value is higher or lower than
that of the blue noise pixel. If it is higher you make the pixel white, if it is
darker you make it black. In the plot below you can see the noise as the gray
background curve. The higher the curve the lighter the pixel value. The gradient
is then the line cutting through it diagonally from pure dark in the lower left
corner, to pure white in the upper right corner. We can then see that everywhere
the gradient line is below the curve we get a black color and everywhere it is
above we get a white color and this will end up as a binary approximation of the
gradient.

<img src="assets/images/screens/thresholding.png" width="100%" style="width:100%; margin-left:0%;" alt="thresholding">

Now, there are two issues with using blue noise dithering. First, aesthetically
I didn't want a pixel level dithering. I wanted my grains to have dimensions and
shape. Second, blue noise takes *forever* to generate at high resolution (we are
talking hours).

However, high-frequency simplex noise have a lot of the same characteristics as
blue noise, can be generated on demand in a shader, and is resolution
independent. So, we simply use that instead...

<img src="assets/images/screens/blue_vs_simplex.png" width="100%" style="width:100%; margin-left:0%;" alt="blue noise vs simplex noise for thresholding">

We see that we substitute the peculiarly pleasant, but also artificially looking
pattern from the blue noise, with something much more organic looking from the
simplex noise. And, as stated above, the grain created by simplex noise can be
rendered at any size while blue noise is forever confined to the size of a
pixel.

There are a bit more to the texture used in Screens than that, but those are
technicalities. I modify the simplex noise in slight ways to make it a bit more
organic and give it some macro features, and if splotches are on I set some
areas to 1 and some to zero based on thresholding another simplex noise of lower
frequency.

In the end this is how I transform those clean screens shown above, into the
grainy, messy, joy that you know and love from the project. And with that last
technicality we arrive at the final piece:

<img src="assets/images/screens/final.png" width="50%" style="width:50%; margin-left:25%;" alt="0x3f6014f3724dd546fcfd9f6dd9f2731bedece5ae37620c2789b7d936ebea50d3">

## Parting thoughts

So, we arrive at our final destination. The last words have been finally said
(from me, at least), about the provenance, context, and technical side of
Screens. I am thoroughly thrilled that so many people have taken this series to
heart and finds joy browsing the collection, perhaps even buying a piece for
themselves. There is no greater privilege as an artist than to be allowed some
room inside the consciousness of others and I can't thank you enough ❤️
