---
layout: post  
title: "Practical Math: My Journey from Idea to Application"
description: "An exploration of the process I went through to turn a casual thought into a real-world math application."
date: 2024-07-29
author: "Ignacio Brasca"  
categories: opinion  
image: "https://blog.ignaciobrasca.com/img/gallery/i00013.jpg"
tags: 
  - math
  - critical thinking
  - engineering
  - research
---

> Disclaimer: I am not a mathematician or an academic, I just only have a deep passion for learning and knowledge.

> Disclaimer 2: This is the "why" I wrote the article in the first place, if you wanna read the technical part of it is [here](https://www.researchgate.net/publication/382651852_Polynomial_Methods_for_Ensuring_Data_Integrity_in_Financial_Systems).

# Introduction

On my last trip to Stockholm to visit company headquarters, I ended up in a park during the lovely Swedish summer, thinking about how to improve our system in terms of data integrity. Right there, I had a eureka moment. 

This post is a summary of how the idea, which was generated from endless conversations with coworkers, ended up being a real practical application of a mathematical problem I was reading about.

After a lot of discussions with coworkers, I realized, after spending a few hours on it, that I should bring tools other than the practical software engineering skills I have been using for the past ten years. These tools should be more oriented towards critical thinking, robustness, and similar aspects.

I vaguely started with [TLA+](https://en.wikipedia.org/wiki/TLA%2B); however, I didn't find any practical usage other than mathematical formality. So, I went back to the research phase.

This, as far as I remember, might be the first time ever I applied literal textbook math to a piece of software (other than the well-known mathematical concepts we use daily).

# Read, Read, Read

A month and a half ago, I was reading [Graham Farmelo](https://grahamfarmelo.com)'s [The Strangest Man](https://grahamfarmelo.com/the-strangest-man/), a biography about the life of physicist Paul Dirac.

I went full fanatic mode into the life of this silent man, and in the end, I discovered that most of the things I knew were simply wrong. (e.g., Dirac wasn't a "silent" man at all. Yes, he was quiet, but his ideas and political views were always there, as a man of conviction.)

![dirac-periels-pauli](https://blog.ignaciobrasca.com/img/posts/random/pic-29.jpeg)

A bit of revelation went ahead in my mind, and a part of me started to see things with a bit of reluctance. Biographies inspire me a lot, mostly in positive ways.

After this one, I immediately jumped into the next one: [The Man From The Future](https://wwnorton.com/books/the-man-from-the-future), about the incredible life of [John Von Neumann](https://en.wikipedia.org/wiki/John_von_Neumann). And oh boy.

The inspiration came immediately. I had to re-learn math.

Throughout my career as an engineer, I spent time reading and learning mathematics, of course, but at the end of the day, I was always learning for someone else, not for myself.

I was always complying with reaching deadlines on time or meeting conditions to take an exam, and so on.

But now, hey, I'm an adult! I can learn this stuff by myself (with the help of thousands of Internet contributors).

At the same time, I was reading [Programmer's Introduction to Math](https://pimbook.org), and their first chapters sparked a revelation.

*We could use polynomials to store our data!*

# Write, Write, Write

Initially, the idea seemed far-fetched, but I had a hunch it could work. However, as someone who does not come from academia, it sometimes feels really "scary" to "publish" stuff.

After tinkering with the idea, I ended up desisting. I didn't want to expose myself to potentially using the method/mechanism wrongly.

Nevertheless, I never stopped thinking about it. Each time we faced an issue that the idea *could* technically solve, I was hitting my head against the wall, just waiting for that moment of anxiety to disappear.

On that weekend during my summer in Sweden, I went through several iterations, from idea to practical examples, and back to the drawing board. On my way back to Valencia, I revisited Shamir’s [How to Share a Secret](https://web.mit.edu/6.857/OldStuff/Fall03/ref/Shamir-HowToShareASecret.pdf) and explored the [Reed-Solomon](https://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction) error correction technique, but neither fit our specific use case. I wanted those to replace my use case so I didn't have to write anything at all.

After a few more days like this, I ended up deciding to write it, saying to myself: `f*ck it`.

So I went full-******* ([Tropic Thunder Scene](https://www.youtube.com/watch?v=oAKG-kbKeIo)) mode.

Rusty on the math level, I had to re-learn concepts from scratch just to refresh that knowledge. After a few days, I started to see the appeal of tinkering and experimenting with different approaches using math as an underlying tool. Then, after tinkering with the idea and the practical examples I was building, I gradually shaped the idea into a feasible solution.

It was time to write.

![my notebook](https://blog.ignaciobrasca.com/img/posts/random/pic-28.jpeg)

I spent the new days reading Google Scholar, Arxiv, the Internet, just to understand if this existed to then realized: I was just wasting my time. I didn't find any substantial.

The last push I needed for my motivation to spark and to reach enough energy to make me write the article was after using [undermind](https://www.undermind.ai/home/). After using their "deep search" functionality, I found that not too many people were tinkering with this conjunction of financial systems, climate modeling, and polynomial mathematical concepts.

![undermindAI](https://pbs.twimg.com/media/GTZ_-LxW4AAlJsk?format=jpg&name=medium)

> I'm not in academia (despite trying), so it might be the case that there are people researching exactly the same thing.

# Give yourself a break

See, coming from the countryside sometimes can be daunting to meet our devils this way. It's really easy to mess up, to make a mistake, and to expose yourself to being a potential laughingstock. However, in the end, one should always be there writing his/her ideas. Pick any notebook. Write your stuff. Don't put the pressure of society on your shoulders; just write whatever you have in mind and with whichever theory you might have. It might exist already, it might be completely wrong, it might be completely useless, but still, it's yours and yours only, and it came from your brain & soul.

It's the only way to show that you're still thinking, that you're still a human with a soul, and not a machine that redirects chemical responses just for the sake of marketing.

Probably no one, other than your close friends, will read what you write (*hopefully I'm 100% wrong on this one*), so even if there is an article in the wild, write it for yourself, learn as you write, and then wait. 

In the end, I end up realizing (partly as I write this post) that I'm not into academia, so why should I play by their rules Since one of the things I suffer most when tinkering with ideas like this is the constant pressure to be absolutely correct and right while publishing in the prestine format.

While I understand the real power of academia, I don't think all ideas should go in that box, not even this one. I'm not here to provide you with an explanation of why science + academia are the most important thing the human species has ever achieved.

Your ideas, the real you, should be as detached as possible from this formal technicalities as you write, because you need to be yourself as you do it. Give yourself time to write, to think, to believe that there really is something you can write about.

Furthermore, finding inspiration is for me, the most important part of the process and mine came mostly from reading biographies and of course, Terrence Tao, and his [On Writing](https://terrytao.wordpress.com/advice-on-writing-papers/). 

I truly believe that it is important for us, for any of us, to write our ideas in the realm of the world. To meet ourselves and who we are as we write.

Finally, after continuous efforts and iterations, I wrote the article in a few weeks. This article. 

In case you want to read the other article (*"the essay"*), you can read more [here](https://www.researchgate.net/publication/382651852_Polynomial_Methods_for_Ensuring_Data_Integrity_in_Financial_Systems).