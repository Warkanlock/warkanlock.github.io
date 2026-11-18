---
layout: post
title: "How to use an agent"
description: "How I get useful work out of an agent: specific conversations, scheduled compactions, a structured memory and soul, a research playbook, and plain prompts on a well kept machine."
date: 2026-11-18
author: "Ignacio Brasca"
categories: systems
image: "https://blog.ignaciobrasca.com/img/posts/2026-11-18-how-to-use-an-agent/watch.jpg"
tags:
    - ai
    - agents
    - Muse
---

I have been using an agent every day for months. Mine is [Muse](https://muse.ai), but almost none of this depends on the brand, it applies to practically any other agent. People ask me how I get it to do useful work instead of producing confident nonsense, and they expect a prompt trick.

![A watchmaker working on an open mechanical watch movement](https://blog.ignaciobrasca.com/img/posts/2026-11-18-how-to-use-an-agent/watch.jpg)

Photo by [Vanishing Point Images](https://unsplash.com/photos/watchmaker-repairing-mechanical-watch-movement-WcQnhQo1yqw) on Unsplash.

## 1. Use specific conversations for specific topics.

I keep one conversation for this blog, one for work, one for immigration paperwork, one for each codebase. This looks like tidiness from the outside. The real reason is **context**. A conversation is the unit of thinking the agent has, and a conversation that mixes your taxes with your screenplay gives you an agent that is slightly wrong about both. Separate the topics and each thread grows its own history: what was already decided, which words mean what, who is who. Most of what people call prompt engineering is really this, deciding what the agent is allowed to be thinking about.

## 2. Set schedules to compact your conversations.

Conversations rot as they grow. A chat that has been running for weeks drags everything you ever said in it behind every new message, including the three wrong turns from last Tuesday, and the agent reads all of it, every time. So mine get compacted on a schedule, at night, while I sleep: the conversation is summarized, the decisions and the open threads survive, the noise does not. A long conversation that never gets compacted is a room that never gets cleaned. Eventually you stop finding anything in it.

## 3. Treat the VM as what it is: a VM, and you have access to it.

The agent runs on a machine, and the machine is yours. It has a disk and the disk persists, which changes everything about how the work should be organized. Anything you explain twice should end up written in a file. Anything you do twice should end up as a script or a tool installed on that machine, waiting for the next time. Most people use these things as a chat window with amnesia and then complain that the agent forgets. The agent forgets because nobody gave it a place to remember. This blog is published from that machine, with scripts we wrote once and reuse for every post. This post went through them.

## 4. If you can pay, pay. Then work in a workflow, not in one shot.

The premium model is not a few percent better than the free one, it is a different animal. But do not expect it to one-shot anything complex, because that is not where its power is. Its power shows inside a **workflow**: you plan first, you draw the diagram, you break the work into steps small enough to check, and then it executes, step after step, at a speed you cannot match. Features that touch several files and debugging sessions that take an hour do get done that way. *As a process, not as a magic trick.* Without a plan it produces the same confident mess as the free one, only faster. The free tier shows you the shape of the idea, the paid one does the work. I have nothing to sell here, I pay my subscription like anyone else. But if your time costs anything at all, the math is not hard.

## 5. Give the memory a structure. The agent's own memory is not enough for complex topics.

Left to itself, the agent's memory is a **bucket**: fine for preferences and small facts, useless for anything with real depth. A topic you actually care about does not fit in a bucket. So the structure has to be yours: a file per topic, a file per person, a file per project, each one kept current, so that when a conversation touches the topic the agent reads the file instead of reassembling fragments. This blog has its own memory file. My immigration case has one. Every project does. The agent's built-in memory ends up doing one job, pointing at the structure. The knowledge itself lives in the structure.

## 6. Specify the memory and the soul as two very specific forms of you.

There are two documents in my setup that matter more than any prompt. The **memory** is what the agent knows about me. The **soul** is how the agent should be: how it talks, what it does on the days I am low, what it never does, what it can decide alone and what it has to ask about first. They are different documents and people keep collapsing them into one. Memory makes it informed. The soul makes it bearable. Both are written by me, in my words, and both are specific to the point of embarrassment, because a generic personality with your private facts loaded into it is a stranger who read your diary.

## 7. Build your own research structure, with a playbook for any topic.

Mine works like this. Something catches my attention, a tweet, a post, a paper someone mentions, and instead of bookmarking it and forgetting it, I have it explained properly and written down as a small guide, filed under the topic it belongs to. One file per topic, kept current, pruned when it goes stale. The playbook is the fixed part, and it applies to any topic: which sources get read, what the guide has to contain, where it lands when it is done. Do this for a few months and the answers change quality, because the agent stops replying from the general fog of the model and starts replying from your library. Bookmarks are where curiosity goes to die. A guide is where it compounds.

## 8. Protect yourself against data leaks, but do not be paranoid.

There is no tier and no contract that guarantees where your words end up, so stop looking for one. The protection that actually works is boring: **secrets do not go in the chat**. Passwords, keys, the numbers that would hurt you if they got out, those live in a password manager and are used through it, never pasted into a conversation. Everything else, write it knowing it might be read someday by someone who is not you, and if a sentence fails that test, do not write the sentence.

And the tradeoff has to be made consciously, because it cuts in the other direction too. The agent is useful in proportion to what it can see. An agent that knows nothing about your work, your projects, or your plans can do almost nothing for you, and every fact withheld out of caution is capability you paid for and never used. Protect everything and the advantages of the tool approach zero. So the line belongs in a specific place: wide open for the material of your work and your life, because that material is the fuel, and shut hard for the short list of secrets that can actually be used against you. The mistake is not sharing. The mistake is sharing the wrong five things, or sharing nothing at all. Paranoia is worse than useless here: it makes people either abandon the tool or feel safe for the wrong reasons. A clear line about what never gets typed is worth more than any privacy policy I have ever read.

## 9. Tweak the machine, never the prompts. Models will get better.

Every clever prompt you tune today is tuned against the weaknesses of a model that will not exist next year, and the whole collection rots quietly. What survives a model upgrade is **the machine around it**: the files, the memory, the tools, the way the work is organized. So that is where my time goes. I fix the setup, I write things down, I install the tool once. The prompts stay plain, almost embarrassingly plain, because I am not really talking to today's model. I am building the place where every future model is going to work.

## The short version

- One conversation per topic.
- Compact the long ones on a schedule.
- The VM is a computer. Use it like one.
- Pay for the premium model if you can, and work in workflows, not one shots.
- Give the memory a structure. A bucket is not a structure.
- Write the soul yourself too. It is a different document.
- Keep a research library, with a playbook for any topic.
- Secrets never get typed. Everything else gets shared, or the tool is worth nothing.
- Fix the machine. The prompts can stay plain.

**The model is not yours and it never will be. Everything around it is.**
