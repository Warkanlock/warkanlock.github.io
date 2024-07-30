---
layout: post  
title: "From Inspiration to Application: My Math Journey"
description: “An exploration of the process I undertook to turn a casual thought into a real-world math application.”
date: 2024-07-29
author: "Ignacio Brasca"  
categories: opinion  
image: "https://blog.ignaciobrasca.com/img/gallery/i00013.jpg"  
---

> Disclaimer: Although I am not a mathematician or an academic, I have a deep passion for learning and knowledge. I am a systems engineer who dedicates my waking hours to reading and learning as much as I can.

# Introduction

On my last trip to Stockholm to visit company headquarters, I ended up in a park during the lovely Swedish summer, thinking about how to improve our system in terms of data integrity. Right there, I had a eureka moment. 

This post is a summary of how the idea, which was generated from endless conversations with coworkers, ended up being a real practical application of a mathematical problem I was reading about.

After a lot of discussions with coworkers, I realized, after spending a few hours on it, that I should bring tools other than the practical software engineering skills I have been using for the past ten years. These tools should be more oriented towards critical thinking, robustness, and similar aspects.

I vaguely started with [TLA+](https://en.wikipedia.org/wiki/TLA%2B); however, I didn't find any practical usage other than mathematical formality. So, I went back to the research phase.

This, as far as I remember, might be the first time ever I applied literal textbook math to a piece of software (other than the well-known mathematical concepts we use daily).

# Read, Read, Read

A month and a half ago, I was reading [Graham Farmelo](https://grahamfarmelo.com)'s [The Strangest Man](https://grahamfarmelo.com/the-strangest-man/), a biography about the life of physicist Paul Dirac.

I went full fanatic mode into the life of this silent man, and in the end, I discovered that most of the things I knew were simply wrong. (e.g., Dirac wasn't a "silent" man at all. Yes, he was quiet, but his ideas and political views were always there, as a man of conviction.)

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

![my notebook](https://blog.ignaciobrasca.com/img/random/pic-28.jpeg)


The last push I needed for my motivation to spark and to reach enough energy to make me write the article was after using [undermind](https://www.undermind.ai/home/). After using their "deep search" functionality, I found that not too many people were tinkering with this conjunction of financial systems, climate modeling, and polynomial mathematical concepts.

![undermindAI](https://pbs.twimg.com/media/GTZ_-LxW4AAlJsk?format=jpg&name=medium)

> I'm not in academia (despite trying), so it might be the case that there are people researching exactly the same thing. I'll go on that topic in the next section.

# Conclusion

See, coming from the countryside sometimes can be daunting to meet our devils this way. It's really easy to mess up, to make a mistake, and to expose yourself to being a potential laughingstock. However, in the end, one should always be there writing his/her ideas. Pick any notebook. Write your stuff. Don't put the pressure of society on your shoulders; just write whatever you have in mind and with whichever theory you might have. It might exist already, it might be completely wrong, it might be completely useless, but still, it's yours and yours only, and it came from your brain & soul.

It's the only way to prove that you are still thinking, that you are still a human with a soul, and not a machine redirecting chemical responses just for the sake of marketing.

Most of this inspiration came from Terrence Tao and his [On Writing](https://terrytao.wordpress.com/advice-on-writing-papers/) however, despite being mostly focus to writing academy I believe it's important for us, any of us, to write our ideas into the realm of the world.

Finally, after continuous efforts and iterations, I wrote the article in a few weeks. This article. 

In case you want to read the other article ("the essay"), you can read more [here](https://www.researchgate.net/publication/382651852_Polynomial_Methods_for_Ensuring_Data_Integrity_in_Financial_Systems).