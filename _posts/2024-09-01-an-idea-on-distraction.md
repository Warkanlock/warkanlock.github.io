---
layout: post
title: An idea on distraction
description: A thought-experiment on how to regain control over our time and attention in a world of constant notifications.
date: 2024-09-01
author: Ignacio Brasca
categories: experiment
image: https://blog.ignaciobrasca.com/img/gallery/i00012.jpg
tags:
  - thinking
  - experiment
  - idea
---

{% include latex.html %}

Suddenly, your inbox is full of messages:

> John: Do you have 5?

You push back from the desk, glance around, and ask the air why, trying to find any explanation that doesn't end with you cursing in unison.

You decide to close the lid of your newest computer and stand up. After five seconds of pure nothingness, you do yourself a favor and prepare another coffee.

You think a bit while grinding the beans and check your phone:

> Someone just wrote a comment on your profile picture!

Fuck.

After leaving your phone on the kitchen counter, you wait a few moments and realize the coffee is ready, but your brain is still not.

> New notification from X

You didn’t even want coffee in the first place, but here you are, waiting for the liquid to seep into your brain so you can reduce focus time, increase productivity, and all while no one disrupts you.

[We want to be 'in the zone' while we surf the web and wait for inspiration to come.](https://www.edweek.org/technology/opinion-the-teenage-smartphone-problem-is-worse-than-you-think/2018/02)

When was the last time you heard birds singing? Or had an idea strike you while walking down the street?

[How can we think as a species if we have a device that prevents this from happening?](https://hbr.org/2018/03/having-your-smartphone-nearby-takes-a-toll-on-your-thinking)

I don’t know where we are going, but I thought of a solution—maybe a silly one, but one that I cannot implement without replicating it `N` times on every device I use (hence I desist from doing so). However, I believe this could be a good write-up to explain what I would love for our devices to have.

## The Problem

All of us [have a problem](https://www.pewresearch.org/short-reads/2024/06/12/72-percent-of-us-high-school-teachers-say-cellphone-distraction-is-a-major-problem-in-the-classroom/), and I don’t believe we will be able to solve it. It’s not just about distraction, attention span, hate incentives, porn addiction, and so on. Even though all of those are demons we need to fight, they have almost always been there in some form.

I won’t go deep into those problems since I believe Anna did a great job explaining pleasure and dopamine in this chapter of **[Hidden Brain](https://open.spotify.com/episode/73hthu5wshqn3uVevKPU9C?si=e1725c127c594e89)**.

Still, I believe our issue is not being able to control what’s going on, and part of that can only be solved if corporations allow us to do so.

Well-being is important, but it won’t be possible if you give yourself a shot of dopamine while watching vertical split videos designed to catch your attention.

Your brain, at first, will be tired but then attracted to it.

We should, at the very least, have mechanisms or devices to control this from our end.

## One Solution

I’m a systems engineer, and every step I take, I always think of problems as systems transporters—little cells that allow me to think a bit more outside the box.

The problem of notifications appeared to me while I was working in my first position as a manager (specifically, interim CTO).

Suddenly, all the time, at any time, whenever and wherever I was, I received someone’s message, thought, comment, or request.

Not because people are rude, but because everyone’s schedule is a part of their own world, and we cannot control that.

Corporations, over time, have allowed this to become a bi-directional problem. Now, it’s not even something you can opt-out of with focus mode.

![don't disturb](https://blog.ignaciobrasca.com/img/posts/random/pic-31.png)
> I mean, you can, right? You can always feel like you can do it…

The same exists within Instagram, WhatsApp, X, Reddit, etc.

You have the sensation that you have control, but in reality, you do not. And you will never understand this unless you try to leave it.

Do it.

Whenever someone else is replying or writing a message to you (or even calling you), please give this person a notification (just in case something urgent could happen) and leave.

Try it.

> It will be harder than you think.

The nerves get to you when you try to prevent these things from happening. Since if you could control who is texting you, it would mean that you could predict people’s behavior, hence you would be in a much better position to deal with this (*looking at you, market solver!*).

Now, almost everyone out there is getting anxious because we feel we cannot control our time. The frustration comes from the same game that you are playing: you cannot not reply to someone in a day; it’s rude! (Technically, you can, but follow me for a bit.)

So, a solution to this problem is what I call

### A Notification Event Coordinator

A `mechanism inside a system`, root-installed in our devices (`all`), that allows us to coordinate the receiving of notifications while those are invisible to us.

![diagram](https://blog.ignaciobrasca.com/img/posts/random/pic-32.png)

It can work as a [Priority Queue Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/priority-queue) where a queue will be in charge of listening and controlling what we receive, enabling us to have a slow-queue for less important notifications and a high-priority queue for urgent ones.

This system will act as a simple gatekeeper, preventing end-users (ourselves!) from receiving notifications at any time. 

Think of it as a mailman who only comes to your place with notifications, letters, and such at the time you specify.

## Explanation 

See, now we receive notifications, but it’s not even a problem: we can silence them. The issue is whenever you see red dots, green pop-ups, numbers beside names, you instinctively think that something or someone is wrong or wants to say something important when in reality, 99.99% of the time it’s just bullshit in a friendly tone.

This coordinator would change this a bit. It would serve as a gateway for all the notifications your system receives (any system—hence I said: it’s mostly on corporations to build this) and act as a gatekeeper whenever you want to **“flush out”** and check them.

I now understand this pattern of always being available as something completely harmful since we need to be in an alert state all the time.

My thought here is that we (as a society) cannot escape this without help from corporations (or extreme coordinated efforts from everyone else). Since if we cannot control the device itself and how the device treats notifications, it will be impossible to bypass and block them for a while until we recognize it’s time to read.

## Conclusion

While I was doing my first managerial job, the sensation of always receiving a message ended up being completely awful, given that every time someone texted me, I thought I was in danger.

My cortisol levels were high, and every day I was in an alert state all day.

After a few weeks of living like this, I almost ended up with burnout. You cannot be alert all the time; sometimes you need to rest.

I decided to remove most of the messaging applications from my phone related to work, and my life started to improve, just to the point of complete relaxation.

After a few days (I believe it was two weeks), I came back to the messaging again, and everything started to fall apart once more.

So, immediately I recognized these sensations and went back again. I deleted everything from my cellphone and got a [feature phone](https://en.wikipedia.org/wiki/Feature_phone) again.

At first, I can imagine a chaotic vibe whenever you *disappear* for a day or two (or whenever you want to receive messages), but I believe in the long term, this will help us out.
