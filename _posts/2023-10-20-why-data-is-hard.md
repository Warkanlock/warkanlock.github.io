---
layout: post
title: "Why data is hard"
description: "What once started as a simple script is now a new Chimera"
date: 2023-10-20 12:00:00 -0300
author: "Ignacio Brasca"
categories: opinion
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-12.jpeg"
---

Imagine you are a small startup trying to get its place in the market.

You start to build a product, and you realize you might need data to fill those empty screens, you start searching through vendors and external services that are in charge of it, and you find out that data, first of all, is f\*cking expensive. But anyway, your company is growing, so it's OK for the CFO to spend a few more bucks on it. After all, you will need this for potential new customers.

You'd think with all the advancements in data storage, processing, and analytics, this would be a walk in the park by now (maybe if you have an infinite budget, it could be). But let's not fool ourselves here: data is as complex as it could be. 

Noise is everywhere, and because of that, issues are so hard to spot.

When you receive the data, you realize that the data corpus you bought is **enormous**. You can't handle it manually.

You start writing a few scripts in that good ol' language you learned during weekends, and by now, you have a good assessment of what you got, and you realize that after running the script, you have something: **more data**! 

After a while using it on your application, customers actually start to see your data as a reliable and unique source of information until you step into a new little friend: data downtime—the data engineer's boogeyman. 

It's around every corner now, and you [may ask yourself, how do I work this?](https://genius.com/Talking-heads-once-in-a-lifetime-lyrics)

So, you start to realize you, by yourself, cannot build something as reliable as what your customers want, and because of that, you start making new friends.

Data pipelines, ETL, warehouses, validation processes, staging environment, quality assurances, and the list goes on [and you may ask yourself, am I right? am I wrong?](https://genius.com/1174888/Talking-heads-once-in-a-lifetime/You-may-ask-yourself-what-is-that-beautiful-house-you-may-ask-yourself-where-does-that-highway-go-to-and-you-may-ask-yourself-am-i-right-am-i-wrong-and-you-may-say-to-yourself-my-god-what-have-i-done)

Anyways, after a couple of weeks, you realize that ensuring quality isn't just a one-time deal you can build and move on; it's a continuous process.

You need to keep asking yourself: is the data up-to-date? Complete? Are the null rates within an acceptable range? Enter data catalogs, more complexity, more people your mind is asking again: "How much data could exist!?**". Even inside your company, the data keeps growing, and now you realize that even the data of your data has data related as well.

This madness needs to stop, but it's too late.

Now, your organization is in the data race. Everyone, every morning, will experience some issue related to this: wrong dashboards, numbers that look OK while, in fact, they are not, lousy scrapping, automatic reporting, customers that want raw data instead of your consumption through the interface, emails are sent in daily basis to your third-party provider, and again, the list goes on and on.

Your software, which you once thought would be only that, software, started to become this monster of data generation. From application logs with diagnostic information to API responses showing how our third-party services interact with event data from devices, each comes with its own set of problems and challenges we need to consider before it happens.

But always remember ["**there are unknown unknowns**"](https://en.wikipedia.org/wiki/There_are_unknown_unknowns)

Just for you to imagine, last week, a slight change in a raw data file from an overseas vendor wreaked one of our internal dashboards. I learned the hard way that quality assurance on the data is a continuous (and costly) battle everyone needs to fight against[ if it's really in charge of producing value](https://www.wired.com/insights/2014/07/data-new-oil-digital-economy/).

Validity, accuracy, timeliness, completeness, correctness, schemas, etc. 

You wake up one day after a couple of months of wrestling with this issue of what, at first, started as a simple and naïve script, you realize you are not only solving a technical problem, but you are building the foundations of a data-driven organization.

And that, my friend, is why data is hard.