---
title: "Becoming The Intern"
description: "The story of how I landed the most prestigious internship within the world of R visualization frameworks."
date: '2016-10-31'
tags: [R, ggplot2, ggforce, ggraph]
categories: [R]
large_thumb: true
img:
    thumb: "/assets/images/becoming-the-intern/the_intern.png"
---

I was not always this famous... And with this I mean that a year ago only my colleagues knew I did *stuff* in R and now I'm reaching a *slightly* wider audience. Some of this is definitely due to me interning for Hadley Wickham and helping prepare the next release of ggplot2. In fact I think it's a fair bet that if you're reading this it is due to Hadley having mentioned me in a tweet at some point in time. Having heard multiple times how huge this internship was I thought that the tale of how I went from a lonesome R programmer to working on one of the more recognized projects in the R world would interest at least someone, so here goes...

### The humble start
As I think is custom for many R users my first stint with R was through the university statistics and mathematics courses. Albeit showing the usefulness of R as a statistics tool these courses were not good at showing the applicability of R in a broader context. In 2008 I was a trainee for a food ingredient company in Paris, France. Discontent with the possibilities of Excel plotting I consulted a coworker for input on how to best plot my data and he began speaking enthusiastically about something called ggplot2, but warned me that it would require knowledge of R. I jumped right in and didn't look back. Through the need for data visualization I gradually improved my understanding of R scripting and data munging. My first package saw the light of day as part of my master thesis (not on CRAN or Bioconductor but see <https://github.com/thomasp85/pepmaps> if you want a laugh). During my PhD things got more serious. I began developing packages meant for release through Bioconductor (and later CRAN) and the review process of Bioconductor was invaluable in improving my coding skills. I also joined GitHub and began to file some issues here and there, as well as asking around at the ggplot2 and shiny Google groups.

At that point I was still an R developer detached from most community interaction, but I was watching the community from afar. No one at my workplace was doing any programming in R (or other languages for that matter), but I had managed to connect with a few proteomics researchers through Bioconductor. After a couple of proteomics-centric packages ([mzID](https://github.com/thomasp85/mzID), [MSGFplus](https://github.com/thomasp85/MSGFplus), [MSGFgui](https://github.com/thomasp85/MSGFgui), and [MSsary](https://github.com/thomasp85/MSsary)) and a few general ones ([shinyFiles](https://github.com/thomasp85/pepmaps) and [densityClust](https://github.com/thomasp85/densityClust)) my PhD got derailed and I was forced to reconsider the whole project. I ended up starting from scratch with comparative microbial genomics and began developing my most ambitious R package yet: [FindMyFriends](https://github.com/thomasp85/FindMyFriends). FindMyFriends is a framework for analyzing and comparing genes from a large set of genomes and it relies largely on a number of custom developed graph representations and analyses. In order to visualize subsets of a larger graph structure I started poking around with how to draw networks with ggplot2. I quickly came up with some wrapper code that could take an `igraph`-object and create a ggplot2-powered node-edgeplot. I have a tendency to continue down a rabbit-hole in these situations and instead of calling it a day I began to investigate how to add arrows to the edges, since the interpretation of my graph structures were highly dependent on the directionality of the edges. ggplot2 has long supported arrows at the end of line segments, but for node-edge plots you generally want to have arrows that touch the periphery of the node rather than the center so the build-in solution didn't work. At this point in time I was fairly confident in my ggplot2-hacking skills and decided to try my luck with a custom geom based on a custom grid grob. The purpose of the grob was to define a line segment as with `geom_segment()` but terminate the drawing at a set length (e.g. 1 cm) from the start and end points. The code I came up with was this:

```r
geom_segment2 <- function(mapping = NULL, data = NULL, stat = "identity",
                           position = "identity", arrow = NULL, 
                           lineend = "butt", na.rm = FALSE, 
                           startAdjust = NULL, endAdjust = NULL, ...) {
    GeomSegment2$new(mapping = mapping, data = data, stat = stat,
                     position = position, arrow = arrow, lineend = lineend, 
                     na.rm = na.rm, startAdjust = startAdjust, 
                     endAdjust = endAdjust, ...)
}

GeomSegment2 <- proto(ggplot2:::Geom, {
    objname <- "segment2"

    draw <- function(., data, scales, coordinates, arrow = NULL,
                     lineend = "butt", na.rm = FALSE, 
                     startAdjust = startAdjust, endAdjust = endAdjust, ...) {
        data <- remove_missing(data, na.rm = na.rm,
                               c("x", "y", "xend", "yend", "linetype", "size", 
                                 "shape"),
                               name = "geom_segment")
        if (empty(data)) return(zeroGrob())

        if (is.linear(coordinates)) {
            return(with(coord_transform(coordinates, data, scales), {
                segmentsGrob2(x, y, xend, yend, default.units="native", 
                              startAdjust=startAdjust, endAdjust=endAdjust,
                              gp = gpar(col=alpha(colour, alpha), 
                                        fill = alpha(colour, alpha), 
                                        lwd=size * .pt, 
                                        lty=linetype, lineend = lineend),
                              arrow = arrow)
            }
            ))
        }

        data$group <- 1:nrow(data)
        starts <- subset(data, select = c(-xend, -yend))
        ends <- rename(subset(data, select = c(-x, -y)), 
                       c("xend" = "x", "yend" = "y"),
                       warn_missing = FALSE)

        pieces <- rbind(starts, ends)
        pieces <- pieces[order(pieces$group),]

        GeomPath$draw_groups(pieces, scales, coordinates, arrow = arrow, ...)
    }
    default_stat <- function(.) StatIdentity
    required_aes <- c("x", "y", "xend", "yend")
    default_aes <- function(.) aes(colour="black", size=0.5, linetype=1, 
                                   alpha = NA)
    guide_geom <- function(.) "path"
})
segmentsGrob2 <- function(x0 = unit(0, "npc"), y0 = unit(0, "npc"), 
                          x1 = unit(1, "npc"), y1 = unit(1, "npc"), 
                          startAdjust = unit(0, 'npc'), 
                          endAdjust = unit(0, 'npc'), default.units = "npc", 
                          arrow = NULL, name = NULL, gp = gpar(), vp = NULL) {
    if (!is.unit(x0)) 
        x0 <- unit(x0, default.units)
    if (!is.unit(x1)) 
        x1 <- unit(x1, default.units)
    if (!is.unit(y0)) 
        y0 <- unit(y0, default.units)
    if (!is.unit(y1)) 
        y1 <- unit(y1, default.units)
    grid.draw(grob(x0 = x0, y0 = y0, x1 = x1, y1 = y1, 
                   startAdjust=startAdjust, endAdjust=endAdjust, 
                   arrow = arrow, name=name, gp=gp, vp=vp, cl="segments2"))
}
drawDetails.segments2 <- function(x, recording=TRUE) {
    devSize <- dev.size()
    transformation <- matrix(c(devSize[1], 0, 0, devSize[2]), ncol=2)
    newVec <- cbind(as.numeric(x$x1)-as.numeric(x$x0), 
                    as.numeric(x$y1)-as.numeric(x$y0)) %*% transformation
    segAngle <- atan2(newVec[,2], newVec[, 1])
    xAdjust <- cos(segAngle)
    yAdjust <- sin(segAngle)
    if(!is.null(x$startAdjust)) {
        x$x0 <- x$x0 + unit(as.numeric(x$startAdjust)*xAdjust, 
                            attributes(x$startAdjust)$unit)
        x$y0 <- x$y0 + unit(as.numeric(x$startAdjust)*yAdjust, 
                            attributes(x$startAdjust)$unit)
    }
    if(!is.null(x$endAdjust)) {
        x$x1 <- x$x1 - unit(as.numeric(x$endAdjust)*xAdjust, 
                            attributes(x$endAdjust)$unit)
        x$y1 <- x$y1 - unit(as.numeric(x$endAdjust)*yAdjust, 
                            attributes(x$endAdjust)$unit)
    }
    if(!is.null(x$arrow)) {
        x$x0 <- x$x0 + unit(ifelse(x$arrow$ends %in% c(1,3), 
                                   xAdjust*(x$size * ggplot2:::.pt)/96, 0),
                                   'inch')
        x$y0 <- x$y0 + unit(ifelse(x$arrow$ends %in% c(1,3), 
                                   yAdjust*(x$size * ggplot2:::.pt)/96, 0), 
                                   'inch')
        x$x1 <- x$x1 - unit(ifelse(x$arrow$ends %in% c(2,3), 
                                   xAdjust*(x$size * ggplot2:::.pt)/96, 0), 
                                   'inch')
        x$y1 <- x$y1 - unit(ifelse(x$arrow$ends %in% c(2,3), 
                                   yAdjust*(x$size * ggplot2:::.pt)/96, 0), 
                                   'inch')
    }
    grid.segments(x0 = x$x0, y0 = x$y0, x1 = x$x1, y1 = x$y1, arrow = x$arrow, 
                  name=x$name, gp=x$gp, vp=x$vp)
}
```

... it didn't work. My custom geom worked fine as long as it didn't use my custom grob and the custom grob worked fine as long as it wasn't called from a `geom` function. Bewildered I pleaded for help on [ggplot2's GitHub issues](https://github.com/hadley/ggplot2/issues/1044). The response I got was this:

![Custom grob, custom geom conversation](/assets/images/becoming-the-intern/custom_grob_conv.png)

This was both a let-down and very comforting. No, I didn't get a solution but on the other hand I was told by Hadley himself that I was pushing the boundaries of his ggplot2 knowledge. I let it go, partly because I became informed through some [`R6` contribution](https://github.com/wch/R6/pull/62) that ggplot2 would be moved to R6 and that this could potentially solve my problem. I was later told that this rewrite (which ended up with being ggproto insteand) was partly a response to my issue with extending ggplot2 with custom grid grobs.

### Extensions abound
I year or so went by and suddenly ggplot2 v2 landed on the users with the possibility of writing extensions. I felt this was a big deal and decided to make a small package where anyone could put their extensions if they didn't feel like maintaining a package by themselves (Bob Rudis had the same idea with [ggalt](https://github.com/hrbrmstr/ggalt) it turned out). I announced the existence of ggforce (I had hoped to call it ggplus but it was already [taken](https://github.com/guiastrennec/ggplus)) on the ggplot2 Google group and hoped for at least a modest amount of feedback:

[![Announcing ggforce in ggplot2 google groups](/assets/images/becoming-the-intern/ggforce_announce.png)](https://groups.google.com/d/msg/ggplot2/nQswW0Fd1Ss/wIKBZ1WZAgAJ)

While the feedback was lacking it became my most stared repository almost overnight (20 stars if I remember correctly). Wondering about what drove the interest I looked at referring sites and saw that Twitter was the top one. Someone had apparently [tweeted about my little package](https://twitter.com/BenBondLamberty/status/684716079072030720).

### Enter Twitter
Full disclosure: I don't understand social media and I have little interest in them. Still, if a single tweet could garner interest in my work I figured it was worthwhile to give it a try so I dusted off an old Twitter account I'd made to get some more dropbox space once and began to tweet. I was surprised to find a vibrant and welcoming R community on Twitter, and I soon gathered some modest interest by tweeting plot examples from ggforce. During the course of this I took up my quest to extend ggplot2 with network plotting capability, albeit at a much grander and more ambitious scale - soon my ggforce tweets were accompanied by examples from the [ggraph package](https://github.com/thomasp85/ggraph). Some of these tweets even got retweeted by Hadley which, for someone new on Twitter, had a huge impact on the attention it got (and on my pride). Somewhere along the course of this Hadley even began following me and we exchanged some brief tweets. I even made my [first PR to ggplot2](https://github.com/hadley/ggplot2/pull/1527) that were merged in (Hooray!).

*[I'm quite sure that I still don't understand Twitter on a grander scale but I must say that the small subset of it that concerns itself with R is a fantastic thing to be part of and I wish I had known about that before.]*

During much of my work with ggplot2 in other packages I had spend a lot of time manipulating gtable structures to make composite plots and I had always been annoyed by how this blocked users from changing scales and themes on the returned object. With the extensibility of v2 I began thinking about how the facetting mechanism could be repurposed as a layout specification if extensibility was added to this part of ggplot2. I tentatively asked Hadley if this was in the pipeline:

[![Asking about future ggproto implementation of facetting](/assets/images/becoming-the-intern/ask_facet_proto.png)](https://twitter.com/thomasp85/status/687373009804521473)

Hadley kind of indicated that his recollection of the facetting mechanism was not great and after a while I decided I might as well take a stab at it and got his blessing:

[![Volunteer for ggrpoto-facet implementation](/assets/images/becoming-the-intern/ask_facet_pr.png)](https://twitter.com/thomasp85/status/727468317074706432)

I set up a ggplot2 branch for this an began a [PR](https://github.com/hadley/ggplot2/pull/1633) in order to have a venue for discussion. Then the most peculiar thing happened:

![Hadley ask for e-mail](/assets/images/becoming-the-intern/hadley_ask.png)

This ended up with the offer of becoming his intern for a couple of month while working on this and other ggplot2-related stuff. To this day I still don't quite understand what made him ask a stranger with little record of programming experience to collaborate on one of his most recognized projects, but I'm sure glad he did...

### Summing it all up
If you have made it this far in the story there's a good change that you hope to learn something from it. I think the overarching morale is that the R community is actually quite small and generally welcoming, so it is very much possible to put yourself into a position of becoming part of a project you care about. Not everyone will be able to pay you for it - I do think this is quite unique - but you shouldn't do open source development for the money anyway (and if I didn't let Hadley down too much he might consider doing this again...). I'm still quite surprised at how "coming full circle" this all seems in retrospect, from my custom grob issue due to a wish for network visualization to ggplot2 extensibility and ggraph and the internship. During it all there was no overarching plan though - sometimes life just sorts itself out in a neat way.
