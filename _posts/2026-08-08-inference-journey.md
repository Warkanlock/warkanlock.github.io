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

Not the model architecture. That part is well documented. I wanted to understand what happens when you hit their API. How does the server receive a request, queue it, load the model, run the forward pass, stream tokens back. The whole pipeline.

So I started from first principles. If I had to build my own inference server, where would I even start. What would the request lifecycle look like. How do you batch requests. How do you manage GPU memory. What happens when the model is too big for a single GPU.

I assumed my laptop was enough. Not for running GPT-4 at scale. But for understanding the system. For proving to myself that I could write a server that receives a prompt, runs it through a model, and streams tokens back.

That curiosity turned into a page: [tools/inference.html](/tools/inference.html).

But something else happened along the way.

I was not just learning how inference works. I was using DeepSeek itself to learn it. Asking it to explain tokenizers. Asking it to walk me through KV caches. Having it critique my mental model of continuous batching. The thing I was studying was also my teacher.

That loop felt different from every other way I have learned anything.

I grew up with textbooks. With a syllabus someone else wrote. With a path that was already laid out. You read chapter one, then chapter two, then you take a test. The order was decided for you. The questions were decided for you.

This was the opposite.

I was building my own book. Page by page, as my curiosity pulled me in whatever direction made sense that day. Tokenizers today. KV caches tomorrow. Speculative decoding because I stumbled on a paper and got curious. The curriculum was not fixed. It emerged from what I wanted to know next, and the LLM met me wherever I was.

The page I built is not a tutorial. It is not a guide. It is my book. A living document of what I understand so far, written for myself, structured the way my brain structured it. Public because maybe someone else finds it useful, but honestly, it exists because I wanted to learn.

I keep thinking about what this means for education.

If you can build your own textbook in real time, guided by your own questions, with a teacher that never gets tired of explaining the same thing five different ways until it clicks. If the material adapts to you instead of the other way around. What does a classroom even look like after that.

I do not have an answer. But I have a page that keeps growing.

[tools/inference.html](/tools/inference.html).
