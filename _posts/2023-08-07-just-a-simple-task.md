---
layout: post
title: "Just a simple task"
description: "How bad could it be, right?"
date: 2023-05-01 12:00:00 -0300
author: "Ignacio Brasca"
categories: work
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-8.jpeg"
---
I recently received a product requirement that read:

`For items in our system, the upload process must account for duplicates. Specifically, we should permit items even if they are duplicates in a customer's organization.`

Eager to tackle the task, I began my day by diving straight into it. I made a few commits, adjusted the table structure impacted by this change, and in no time, everything seemed to be functioning perfectly in my local environment.

Next, I updated the interface to allow for duplicate identifiers. However, as soon as I made this change, a series of unexpected issues arose.

Initially, we decided that customers should be notified when they upload duplicate images. Additionally, these items should be marked with a `(duplicate)` label. Implementing this seemingly simple feature turned out to be more challenging than anticipated.

While testing the tool locally, I discovered an issue: `The newly added label disrupted the app's layout, causing visual glitches.`

With my limited CSS knowledge, I attempted to rectify the problem, only to encounter another one.

Every element in our system possesses an `identifier`—a unique value that allows customers to associate images with other sections of our platform. Allowing duplicates of this identifier could complicate user data. This prompted me to examine the database schema, where I thought about adjusting the unique constraint to prevent duplicates. However, modifying the constraint we were using posed challenges.

But then, I realized: `relational databases`.

Just the table I was about to alter was linked to at least five other tables. The unique constraint I was thinking of modifying was associated with nearly ~20M elements through an index.

My day keeps improving. 

By now, I found myself waiting for the `DROP CONSTRAINT` to take effect (two hours and still here, waiting)

This was just a simple task, right? How bad could it be!?