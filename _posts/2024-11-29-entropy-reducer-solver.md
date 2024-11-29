---
layout: post
title: "Entropic Reduction Solver"
description: "An hypotetical system that allows us to reduce the entropy of a set of solutions to obtain a finite result."
date: 2024-11-29
author: "Ignacio Brasca"
categories: opinion
image: "https://blog.ignaciobrasca.com/img/gallery/i00079.JPG"
tags:
    - idea
    - opinion
    - project
---
{% include latex.html %}

Today (2024), generative artificial intelligence allows us to generate infinite solutions, but the problem is that we cannot prove that these solutions are related to a particular real output. We can, correlate them and approximate the solution as a function of a given distance in a latent space, but we cannot prove this as a fact.

To me, this is a problem whenever we want to apply this to deterministic systems, where we need to prove that a given solution is the correct one no matter what.

Now, let us imagine a system that can generate us a set of infinite solutions $$X$$; for these, we take them and assign to each a probability of success given by its correlation with the actual output $$Y$$. 

Let us now imagine a solver, logically deterministic, that allows us to prove that $$X$$ is really related to $$Y$$, no likelihood involved.

The solver should be designed in such a way as to allow us to make from generic inputs and outputs, a discrete result.

This system should work as a pipeline that ingests random values and from there reduce the entropy of the set to obtain `a finite result`.

This is a multi-million dollar problem.
