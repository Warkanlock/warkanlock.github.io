---
layout: post
title: "Look mom! I built a computer"
description: "A journey through building a computer from scratch."
date: 2023-11-23 12:00:00 -0300
author: "Ignacio Brasca"
categories: programming
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-15.jpeg"
---
> Behind it all is surely an idea **so simple, so beautiful, that when we grasp it - in a decade, a century, or a millennium - we will all say to each other, how could it have been otherwise?** **How could we have been so stupid?**
*> John Wheeler, 1986*

## The Book

A couple of months ago, I embarked on building a computer from scratch during the weekends…

![book](https://blog.ignaciobrasca.com/img/posts/programming/pic-10.png)
> The Elements of Computing Systems

I decided to take this as a personal challenge that sums up my career (system engineering) and put a bow on the knowledge I have been ingesting since I started learning about computers.

After researching and rummaging through my infinite list of favorites I came across a comment on hackernews that mentioned nand2tetris; reading more about it seemed like a great resource to start with if I wanted to start building a computer although it seemed, from the outside, a bit too scary without common knowledge although at the same time it was, apparently, pretty standard.

So, I bought the book... (*no more digital books for me*)

After a couple of weeks it arrived: I turned the first few pages like a child, learning and being amazed at how quickly and easily concepts can be grasped if you have them in front of you, imitating examples of theories that you can really feel. 

But the fun started to appear as soon as I started with the implementation.

> **Note**: You cannot continue this book without reading it, skipping parts, or even “cheating” by reading responses on the Internet. In order to solve the issues the book presents, you need to understand the fundamentals.

I continued like this for a couple of weeks, as a kid learning from scratch again binary, binary math, bitwise operations, fundamentals about computer architecture, and a lot of stuff I forgot during the years. 

However, now, I felt differently. Now, I feel that I can actually explain why, how, and what is related to a computer (at least a simple one, lol)

I believe this book made magic for me, and I hope, after reading this, it will make magic for you. However, reading through pages might not be as simple as reading a science fiction book. It takes time and allocation of a lot of energy to get it done and actually feel you are learning.

Solutions to chapters are publicly available, [even mine](https://github.com/Warkanlock/nand2tetris-practice) but please, don’t cheat; you are just fooling yourself. I will confess that in one exercise (I believe it was the first of DFF), I copied a reply from a user, but in the end, I was more lost than when I started because I had two problems: mine and the understanding of the solutions I was just using. I ended up tearing everything down and starting again. 

## The Computer

The practical computer described in the book is a design based on [Harvard architecture](https://en.wikipedia.org/wiki/Harvard_architecture), easily accessible on the Internet, that makes our lives easier through the course without cutting too much of the edges of the knowledge you will need to understand what’s happening. For me, the only architecture that made sense was von Neumann's, virtually everywhere. I was so wrong. 

![computer](https://blog.ignaciobrasca.com/img/posts/programming/pic-computer.png)

Starting from Chapter 1, you will feel like you are doing something really silly, but you are not. Each logic gate you are implementing will be incredibly insightful for the understanding of the computer ([DMux](https://www.allaboutcircuits.com/textbook/digital/chpt-9/demultiplexers/), I’m looking at you!)

There’s just one chapter that feels a little bit “confusing,” but in the end, in the next one, you will understand why it was confusing. 

The best one, in my opinion, is the one in which you implement memory (chapter 3), really abstract but technically there. ***Memory***.

By the end of chapter 5, you will have a working computer inside your computer (for real), but the most important thing, you will never fear this kind of black magic knowledge again.

## The Community

The best part of this book is that you never feel alone through the pages. You might not be part of a computer club that’s building it, or of a University during an assignment, but you will never feel yourself in a lost situation where you will not know where to go.

![forum](https://blog.ignaciobrasca.com/img/posts/programming/pic-11.png)
> nand2tetris project forum

It was incredibly insightful for me, to write in this forum [and receive a response after a day](http://nand2tetris-questions-and-answers-forum.52.s1.nabble.com/Confused-about-total-memory-allocation-td4037376.html#a4037378).

## Conclusion

As Feynman said,

> What I cannot create, I do not understand

Reading pages and pages of *Surely You Are Joking Mr.Feyman*, you can feel how this man used to learn. He was built differently, but also he has the curiosity to understand things from first principles. He used its symbol mathematical notation, just to put an example, because it was practical for him to learn this way.

In my view, I strictly believe this is the only way to learn, practically speaking. I always felt this way: pushed by the boundaries of the limits of the knowledge presented in a box, a book, or an exam, and because of that, I tended to avoid tutorials, guides, or even books regarding a matter that claimed to teach you a topic. 

The only way to learn is by building it and understanding each moving piece whenever possible.

![pareto front](https://blog.ignaciobrasca.com/img/posts/programming/pic-9.png)

Whenever you ask yourself a question that you cannot reply to, you should learn to do it. 

In your field, you should embrace the [**Pareto Front**](https://en.wikipedia.org/wiki/Pareto_front) and actually be good at something you love. 

It just takes a little more effort and a lot more time but the results are more much rewarding.
