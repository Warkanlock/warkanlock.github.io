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

I've been playing with LLM inference lately.

Not the training side. That part is well understood by now. The inference side. The part where a model actually runs, token by token, and produces something you can read.

I built a small page to help me think about it: [tools/inference.html](/tools/inference.html).

It started as a scratchpad. I wanted to understand why DeepSeek's API behaves differently depending on how you configure it. Temperature at 0.7 gives you one kind of reasoning. At 0.3, something else entirely. Top-p, max tokens, all of it. Each parameter pulls the output in a different direction.

What surprised me is how much you can learn just by watching.

Give a model the same prompt twice with different sampling parameters and you get two completely different chains of thought. One might spiral into repetition. The other might lock into a thread and pull something interesting out of it. The difference between them is just a few knobs.

Inference is a small system. Prompt goes in, parameters shape the distribution, tokens are sampled, and something emerges. Turn a knob, the output shifts. It's predictable in the same way a river is predictable. You know the general direction, but not the exact path.

I find that beautiful.

The page is not done. It's a living thing. I'll keep adding to it as I learn more. For now it's what I wish I had when I first started poking at these APIs: a place to experiment and build intuition.

If you've ever wondered why your LLM outputs feel different between runs, maybe it helps.
