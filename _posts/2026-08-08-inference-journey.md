---
layout: post
title: "An inference journey"
description: ""
date: 2026-08-08
author: "Ignacio Brasca"
categories: systems
image: /img/posts/random/old-me.jpg
tags:
  - inference
  - llm
  - tools
---

I got curious about how DeepSeek actually works.

Not the model architecture. That part is well documented. I wanted to understand what happens when you hit their API. What does the request look like under the hood. How does the server receive it, queue it, load the model, run the forward pass, stream tokens back. The whole pipeline.

So I started from first principles.

If I had to build my own inference server, where would I even start. What would the request lifecycle look like. How do you batch requests. How do you manage GPU memory when multiple users are hitting the same endpoint. What happens when the model is too big for a single GPU and you need to shard it.

I assumed my laptop was enough.

Not for running GPT-4 at scale. But for understanding the system. For proving to myself that I could write a server that receives a prompt, runs it through a model, and streams tokens back. Something that could, in theory, serve inference to a few thousand people if the hardware allowed it.

That curiosity turned into a page: [tools/inference.html](/tools/inference.html).

It is a work in progress. Part scratchpad, part documentation, part playground. As I figure things out I write them down there. Tokenizers, KV caches, continuous batching, speculative decoding. Each piece I understand gets a section.

I am not trying to compete with anyone. I just want to know how the thing I use every day actually works.
