---
layout: post
title: "Just a simple task"
description: "How bad could it be, right?"
date: 2023-08-07 12:00:00 -0300
author: "Ignacio Brasca"
categories: work
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-8.jpeg"
---
I recently received a product requirement that read:

`For items in our system, the upload process must account for duplicates. Specifically, we should permit items even if they are duplicates in a customer's organization.`

Eager to tackle the task, I began my day by diving straight into it. I made a few commits, adjusted the table structure impacted by this change, and everything seemed to function perfectly in my local environment. I updated the interface to allow for duplicate identifiers and the server to accept this duplicate item. 

However, a series of unexpected issues arose.

Initially, we decided that customers should be notified with an error message on the interface when they upload duplicate images. After the message, block the action. Although now, the requirement makes that these items should be marked with a `(duplicate)` label otherwise, users might end up seeing the same item twice without even noticing the duplicate in the first place. *(similar to what OS does when you `copy-paste` the same file twice at the exact location)*

Implementing this was a seemingly simple feature but was more challenging than anticipated...

While testing the tool locally, one of the issues was that the newly added label disrupted the app's layout, causing visual glitches. With my limited CSS knowledge, I attempted to rectify the problem, only to encounter another one.

In addition, each file in our system has an `identifier`—a unique value customers use to correlate images with other parts of our platform. With the allowance of duplicates, another problem arises and a more underlying one: **this identifier could appear twice**, referring to a component inside our system twice, which might end up being read wrongly on product stats, insights & other use cases. This led me to the database schema to prevent our services from writing only when the unique constraint is satisfied. 

Another issue was trying to eliminate the unique constraint in the first place. Suddenly, after thinking about how to do it effectively without losing data, I realized: `relational databases`. The table I was about to alter was linked to at least five other tables. The unique constraint I considered modifying was associated with nearly ~20M elements through an index.

My day keeps improving.

By now, I found myself waiting for the `DROP CONSTRAINT` to take effect (two hours and still here, waiting)

This was just a simple task. How bad could it be!?

### Conclusion
In my personal experience, no task is ever as straightforward as that initial commit to the system.  

As projects evolve, complexity inevitably increases. Regardless of how meticulously you've planned the architecture, you'll find yourself navigating a myriad of micro-decisions to implement just a single feature or product requirement. 