---
layout: post
title: "Bosses and bad ideas, a tale from corporate software"
description: "Some recommendations on how to behave when our bosses make bad decisions and also how to take advantage of them for your long-term career."
date: 2022-01-08 12:00:00 -0300
categories: opinion
---

> #### Disclaimer
>
> I know that not all bosses are the same and that every company you work for is a different world so this article is about those "similarities" that someone in a leadership position has that you can take advantage of.

## A little bit of history

At the time I was working at **PwC** I was learning a lot about the [internal processes](https://www.investopedia.com/terms/b/bureaucracy.asp) and how to behave in the ecosystem, but in the midst of this nightmare of compliance and NDAs, I started to pick up on some details.

Things were out of the context I expected from such a large company, but month after month I started to learn to expect almost anything from my boss. That's why I thought it would be a good idea to launch some recommendations on how to deal with this kind of situations that are not as bad as they seem if you handle them well.

These suggestions come from my period there...

![boss had an idea](https://blog.ignaciobrasca.com/img/posts/pic-1.png)

> source: u/cheapshotdraw

## Don't be a mercenary

> We need teams of missionaries, not teams of mercenaries.
>
> John Doerr

In situations where bosses go like crazy asking for things not humanly possible, **you have to take advantage of it**.

You don't have to become a mercenary, because mercenaries build things without dealing with the situation, they just build. Building is not necessarily bad, but you, as a software developer, have to be able to understand the problem to become an expert of your domain. Almost anyone can write code in the software biz (up to certain level) but understanding complex real-case scenarios like: tax management, transfer pricing, internacional taxation, is not something you can learn in a blog post or video tutorial. **That's your advantage, the domain in which your boss is trying to figure things out**.

## Don't overestimate your boss

You may ask `why?` and it is simply because these people think and try to solve at another level a series of problems in their domains. With a few exceptions to the rule, they don't care about the new release of V8 engine. They simply don't care about Rust vs C++ performance. They are experts at doing what they do and that's why they are bosses and for that reason you need to listen to this people, hear their problems. Not always in your life you will have a situation where someone in a leadership position like your boss asks you to solve a problem they are having without too many restrictions. You have to use this as leverage.

One does not normally have the opportunity to experience the problems that bosses have (perhaps if a manager could experience some of this) so this is an excellent opportunity to take that knowledge and scale it to a solution. Chances are that if your boss mentions the word `PoC` your project will be scrapped after a month of completion, but the knowledge you can gain from this process is invaluable.

I'll put a personal experience here:

While working at PwC I started with almost zero knowledge of my responsibilities inside the company but day after day my boss did a lot of meetings with my group trying to explain a really complex problem about **tax** and **[knowledge transfer](https://en.wikipedia.org/wiki/Knowledge_transfer)**. Obviously back then I had no idea what was going on until a few weeks later I had it, and that day, something inside me clicked. You don't have to worry about the details of the application but focus primarily on the problems they want to solve. That's your advantage in this nerve-wracking situation.

## Learn to say no

> Recongnize that while most people prefer compilments over criticism,
> there is nothing more valuable than accurate criticism.
>
> Ray Dalio

Your boss could make your learning path a living hell if you are not up to par, so you should avoid stupid ideas by simply saying `no` and giving a correct explanation as to why it is not feasible to do so. About saying that X is not possible, I have a personal rule for that which I will share below:

One thing I do every time I have to block or prevent something from being done is to try to explain `why is not possible`. It's a really simple algorithm:

**Could you explain what's happening that it's blocking the solution?**

```
(1) Could you explain why X is possible in a clear and simple way by write or in a meet?
    Yes {
        X is possible so there is no need to panic
    }
    No {
        Is your explanation clear?
            No {
                You don't have all the information about X,
                keep researching,
                put in paper your knowledge,
                repeat step (1)
            }
            Yes {
                Is there any possible alternative for X?
                    If yes {
                        X is maybe possible but using another approach,
                        repeate step (1) with new information
                    }
                    If no {
                        Is likely that X is not well formed as a problem
                        or something is missing in the hypothesis,
                    }
            }
    }

where {X} is a subset of a problem
```

1. If you **_can_** describe the solution, you can **build** it.

2. If you **_cannot_** explain by **voice** or **text** what's happening with the solution, in a clear and simple way, is likely because you don't have all the information you need to guess why the solution is not working. In that case you can: **keep searching** or if you are getting tired, **give up**

You see, most of the time your **solution** and your **block** to making the solution a reality are almost blood brothers. If you can't build, at least you can take the time to **explain** why.

It's your duty to learn to say no (with a correct explanation) to your boss because it's your leverage, use it to your advantage. They will appreciate that gesture.

![boss had an idea 2](https://blog.ignaciobrasca.com/img/posts/pic-2.png)

> [The Boss Had An Idea](https://dilbert.com/strip/2021-02-06)

## Expect to learn

> All that matters is that you do love it and that you do care.
>
> Jim Collins

This will be short and easy: _just learn whenever possible_.

Don't get mad if they change product plans after one month of starting with the latest version of `K8s`. If you like to learn, having a boss with strange requirements week after week will make you the most happy person in the world, simply because you will have a lot to learn and also a common playground to put in practice those things you learn.

I personally started with React (I was working with Angular) because a petition of my boss of building a real-time English-Spanish translator (we also needed to build that! no google allowed) in real-time using React as a frontend. Fun fact: we did it in two weeks after a demo and it worked pretty well actually.

Obviously, PoCs were just that, proofs of concept, but at the end of the day, the learnings and insights stayed there and that was amazing.

## Conclusion

If you have at your workplace someone that: at `any time` step in front of you and say something like the following phrase:

> We need a `XYZ` in the company, a lot of hype around it. You and your team will have this `N$` resources. As you can see on your calendar, now we will meet once a week to discuss details.

**Run away from that place if you are serious about software.**

Developing software is almost like witchcraft nowadays, a religious process to turn ideas into something real.

Software, just like someone who build bridges, needs blueprints, planning, estimates, understanding of the problem and also understanding of the solution provided.

So, if someone above you, makes this kind of situations a routine, you will have to be able to say **No, it's not possible**.

It is in your hand and in the long run it will serve you to jump ship in time. Software cannot be taken lightly or if you think it could [you can check how Linus Torvalds tolerates an error](https://lkml.org/lkml/2012/12/23/75). It's something that requires a huge amount of human intervention to make it usable (for now) and it's a shame to waste human effort this way.

**So, if you are serious about your work you have three options (at least):**

1. Make that situation stop, if it's possible, by talking with your boss
2. Make the most of it for your own good and leave whenever you feel up to it
3. Go to a better place.

Although, if you don't have too much experience building anything or are just a curious person looking to learn a little bit about everything these types of situations are for you. You'll be more than happy to have a boss like this, at least for a few months.
