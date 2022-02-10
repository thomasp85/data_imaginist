---
title: "Screens"
description: "Screens is a generative art series released on ArtBlocks curated. This page will contain information, background, and updates on the series."
large_thumb: yes
img:
  thumb: assets/images/rapture_0.png
editor_options: 
  markdown: 
    wrap: 80
---

Screens is a generative series launcing on ArtBlocks Curated on January 31st,
12:00p CT. This page will contain additional information and background about
the project, after it has launched.

<iframe allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="100%" sandbox="allow-scripts" src="https://generator.artblocks.io/255000000" width="80%" style="min-height: 500px; margin-left: 10%">

</iframe>

*Screens #0*

## Background

Screens is the continuation of an idea and vision that started with my
Constructive series (released in August 2021). The primal aim was to explore the
aesthetics offered by screen printing techniques, and this naturally led me to
explore the poster prints from both Bauhaus artists and Russian constructivism
artists. Thus, while working on Constructive, the focal points where strong
geometric compositions, strong simple colour palettes, gradients using a
rendering technique mimicking screen printing.

<img src="assets/images/constructive11.jpg" width="50%" style="width:50%; margin-left:25%;" alt="constructive 11">  
*Constructive 11*

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
*The making of #923*
  
  
<img src="assets/images/screens/255000923.jpeg" width="50%" style="width:50%; margin-left:25%;" alt="Screens #923">  
[*Screens #923 — final*](https://www.artblocks.io/token/255000923)

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

<div style="display:grid; grid-template-columns: 1fr 1fr; grid-gap: 20px; margin: 20px">
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

716 + 521

##### Spiral actor

The spiral actor is one of the more versatile of the five. It creates screens
that spirals towards a randomly selected center. The start distance and angle
relative to the center is chosen at random. All screens from the same spiral
actor follows the same rotational momentum, but this momentum can vary between
different spiral actors, giving rise to both strongly winding spirals and almost
straight lines towards the center. This means that while the actor is *spiral*
by name, the look of the resulting screens can range from spirals to burst.
While screens from the same spiral actor cannot cross each other, they have the
potential to get very near to each other. Because of this each screen is
terminated if it gets within a threshold distance to other screens from the
spiral.

230 + 423

##### Straight actors

This actor is probably the simplest, but has the possibility of creating the
some of the strongest clean composition. Further, due to it's simplicity it
works well in unison with other actors where it creates interest without overly
complicating the composition. The screens from the straight actor all follow the
same angle and is distributed along a shared line. Like circle and square
actors, the screens from a straight actor can be condensed around the shared
line or uniformly distributed out to a max distance from the line.

380 + 78

##### Spline actors

This actor sets up 4 or 5 parallel lines that acts as control points for a
clamped open B-spline. Each screen is based on a location along the control
point lines, e.g. a screen placed at 0.25 would derive its control points a
quarter along the lines. Further, it has a start and end from 0 to 1 (B-splines
are parameterised between 0 and 1). As with spirals, Spline screens has the
potential to get very close to each other so they also check for and terminate
at too close proximity to other screens. Spline actors are the only actors
capable of creating screens with a more wavy feel and the possibility of
changing directions multiple times. This offers some unique possibilities in
composition.

613 + 983

#### Scenes

The actors define how screens are created - the scenes defines which actors are
used and in what capacity.

##### Hero

Potentially the most easily recognised scene. It consist of a single actor
placed inside the frame creating 100 screens. Because a single actor cannot
create intersecting screens the hero scene has a very clean and striking look.
However, there is also not much room for emergent compositional traits to arise.

921 + 395

##### Collapse

Like hero, the collapse scene only consist of a single actor type. However, it
contains 50 of these actors placed both inside and outside the frame, each
giving rise to a single screen. Because of the ensuing chaos this scene is the
one with the highest potential for unique emergent compositions and quite a few
of my own personal favourites are of this style. The reason why this approach
refrain from resulting in pure chaos is that each screen shares a common
dynamic, thus unifying them in the same compositional harmony.

86 + 473

##### Company

Company is the last of the scenes only using a single actor type. It consist of
two of the same actors, placed inside or outside the frame and each creating 50
screens. This style is often one of both harmony and strong geometries, though
certain setups can of course create dissonance.

999 + 315

##### Antagonists

This is like company but with two different actors instead of two identical
ones. While the name implies tension, that is not always the case. The
combination of e.g. a circular and straight actor might just give rise to a some
of the interest that the cleanness of a hero lack.

843 + 701

##### Crowd

The crowd scene consist of three actors, two of which are of the same type. Each
of these gives rise to 30 screens Once you up the number of actors to three
there is a high probability that things end up dense and chaotic. The harmonics
of the two actors of the same type somewhat works to counteract the chaos, but
the last actor is bound to throw a wrench into the effort. Thus this style will
often balance between harmony and tension.

680 + 445

##### Order and Chaos

The last scene style consist of 3 actors emanating 30 screens, just like the
crowd style. However, this time all 3 actors are of different types. It follows
that any type of harmony is generally only obtained through chance and that
chaos is the name of the game. Remember that chaos is not used derogatory, but
simply to describe the feeling the composition elicit in the viewer. Screens has
been designed to encompass this diversity in emotional responses to the
compositions --- an overabundance of harmony quickly becomes boring.

408 + 14

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

889 + 865

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

498 + 374

##### Dominating

Dominating might seem like a variation of spacious but it's effect can be
massive. Like with spacious, intersections are clipped and a buffer zone is
applied. However, with dominating a single actor is selected to always "win" in
the battle of who gets clipped. This means that screens from a single actor is
left intact while the remaining screens fight it out. It is natural that the
dominating actor ends up, ahem, dominating the piece.

876 + 348

#### Screen types

The last trait having a strong direct impact on the composition is the height of
the screens. The concept is pretty simple and encodes how far downwards the line
is extruded to make a screen.

##### Tall 

Tall screens are basically extruded to infinity making sure that nothing behind
them will ever be visible. This is the prevalent look and the setting that most
often leads to harmonious and dense compositions.

901 + 795

##### Medium

Medium screens are just tall enough that they often times look tall, but thin
enough that there is often a couple of places where you get to see underneath
the screen and what is behind it. This leaves room for the solid background
colour to shiny through giving rise to interesting negative spaces and shapes
that would otherwise not be possible.

989 + 654

##### Thin

Thin screens are, well, thin. So thin in fact that often the resulting
composition is dominated be the background and the negative space.

16 + 642

##### Varied

With the varied trait one actor will get tall screens while the remaining actors
will get screens ranging from thin to medium. The effect is that instead of the
background being visible underneath the screens you'll see the structure of the
tall screens. Visually you often get the feeling of seeing the thinner screens
floating in between the infinitely tall screens.

961 + 859

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

545 + 976

##### Autumn

571 + 333

##### Rythm

765 + 603

##### Bauhaus

822 + 771

##### The Avenue

454 + 87

##### Iceland

192 + 290

##### The Refuge

957 + 544

##### Somebody that I used to love

947 + 700

##### Rhino

249 + 941

##### Penguin

199 + 141

##### The Jungle

609 + 251

##### Stencil

261 + 756

##### இڿڰۣ-ڰۣ--- (Rose)

543 + 298

##### Dreams of a Distant Memory

538 + 299

#### Colouring scheme

While the palette sets the stage, the colouring scheme defines the feel. While
the different styles doesn't scream at you they do carry an enormous weight in
terms of the composition of the final piece.

##### Chaotic

This is the "everything goes" version. For each side of each screen two colours
from the palette are chosen at random which defines the gradient. The result is
definitely the busiest of all the colour schemes, especially when combined with
primary colour palettes such as Bauhaus.

937 + 58

##### Condensed

Here, every actor gets a colour assigned from the middle range of the palette
(that is, every colour except for the lightest and darkest). Each side of each
screen then randomly selects to colours from the assigned colour + light and
dark. This creates very well defined actors, bringing more structure to the
piece.

827 + 695

##### Gradient

Gradient works kind of like Condensed, but instead of getting a colour assigned
based on which actor the screen emanates from, it gets a colour assigned based
on its position along the y-axis. As with condensed, it create structure, but
the structure comes from proximity, not from the actor, thus creating groupings
between otherwise unrelated screens.

825 + 720

##### Calm

This colourway is probably not one you would notice... It's like a more
cool-headed chaotic. Like chaotic, each side of each screen is assigned 2
colours at random, with the single constraint that the two colours must be
adjacent in the palette. Since all palettes are sorted roughly by darkness it
means that all gradients in the piece ends up being very calm and low-contrast,
resulting in an overall less aggressive vibe.

806 + 181

### Wait, somethings not right...

After reading this you might find yourself browsing the collection for specific
traits to get to know them better and you may stumble upon something that
doesn't quite fit... A Crowd with only 2 actors, a chaotic style with colours
missing --- you name it. The truth is that not everything is under my control.
Things get drawn both inside and outside the frame and while everything
influences the end result, it might not be apparent how or when said influence
happens.

Take the case of #957 - the space station.

957

Classic hero, right? Wrong! In reality it is an antagonists... We can see this
if we zoom out:

975_zoom

This is what happens if an artist gives into and embraces chaos. So is 957 a
hero or antagonists? Who cares... The traits in Screens are more about the
potential in piece than hard truths about the outcome. Browse and use them with
a healthy dose complacency as to their importance. Knowing *about* the traits in
Screens can certainly help you understand and contextualise a piece, but they
will never capture the essence.

## Want more?

This page will be updated with a technical deep-dive into the system. Please
check back at a later date, or keep an eye on my Twitter feed for updates.
