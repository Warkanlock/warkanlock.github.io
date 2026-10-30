---
layout: post
title: "Building with direction"
description: "A generalist agent needs one small unit that owns the direction, and everyone else building inside it."
date: 2026-10-30
author: "Ignacio Brasca"
categories: systems
image: "https://blog.ignaciobrasca.com/img/posts/2026-10-30-building-with-direction/compass.jpg"
tags:
  - ai
  - agents
  - architecture
---

Most teams building with new intelligence tools have the same problem. Fast resolution with a correct direction. Velocity.

There are many [kinds of agents](https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf) now. Generalist, specialist, [orchestrators](https://www.anthropic.com/engineering/building-effective-agents), and a few other shapes that appear every month in a new kind of flavour on how to do something in the best possible way. This reminds me of the long, almost obnoxious conversations of [tabs vs spaces](https://xkcd.com/1989/), React vs the X framework of the moment, GC and non-GC languages, JIT or not, PHP vs ASP.NET, and you can probably mention a few more.

Before you build anything, you have to pick what you are building, and the most important question: why. Most teams never make that choice explicit, since they arrive with a potential cargo cult from both the new and the old company, so they end up building all of them, at once, badly.

[Cargo cult](https://calteches.library.caltech.edu/51/2/CargoCult.htm) is harmful.

Anyways, going back to nowadays and development, we have at least two kinds of agents, which we can call:

- A generalist, like [Claude](https://claude.ai), can do a bit of everything. That breadth is the point, and it is also the problem. Every specific domain brings its own complexity, and that complexity gets attached to the generalist. Claude is good at a lot of things, but it is still not as good as [Hex](https://hex.tech) at working with data, or [v0](https://v0.dev) at building a website. No single team owns all those domains well enough to beat the specialists at their own game.
- A specialist, like Hex or [Lovable](https://lovable.dev), does the opposite. It makes one dimension of a problem easier: gathering data, aggregating it, building an interface. Then it gets obtuse the moment you ask it to solve the rest of your needs. It will get there, eventually, although most products do not have that kind of time.

So the question is not if we need to build either a generalist or a specialist. The question is who builds what in the pipeline, and most importantly, who is the owner of the problems when something goes wrong. At first, you might need a generalist approach to problems, but most likely specialists will be better.

I will even stretch this idea to the point that, as it was before, computation will always win. The [bitter lesson](https://en.wikipedia.org/wiki/Bitter_lesson).

![Vintage brass compass on a dark surface](https://blog.ignaciobrasca.com/img/posts/2026-10-30-building-with-direction/compass.jpg)

Photo by [Sasun Bughdaryan](https://unsplash.com/photos/a-vintage-brass-compass-rests-on-a-dark-surface-Lh0X0jXWqDo) on Unsplash.

## One unit, generalist shape

I keep seeing the same setup, iteratively, as we go and build products.

One small unit, probably one or two people, starts to become a bottleneck. Why? Because they are doing it fast. A ticket arrives. They build a feature in a day or two. Call it a day, and the process repeats. The day fills up with other people's priorities, and nobody is actually setting a direction. They just build for the sake of doing it.

The problem here is that without direction they will probably reinvent the wheel, themselves, and even their own [version control](https://www.anthropic.com/research/redesigning-source-control).

In my opinion, the shape is backwards.

That unit should not be a service desk, but the executor pushing forward in one direction, and everyone else should lean on that direction.

Set a team of the most expert people in the direction, and make the rest push forward, to generate sufficient energy to be unstoppable.

What I mean with this is: make a super small team to own the primitives that make an agent work at all:

- The [harness](https://blog.ignaciobrasca.com/tools/harness) that runs it
- [Memory](https://docs.langchain.com/oss/python/langgraph/persistence)
- [Context retrieval](https://www.anthropic.com/news/contextual-retrieval)
- [Guardrails and safety](https://docs.nvidia.com/nemo/guardrails/latest/)
- Testing and interaction patterns

And, in practice, make them explicitly the owners of these pieces:

1. [Data control](https://platform.openai.com/docs/guides/your-data)
2. [Retrieval](https://www.anthropic.com/news/contextual-retrieval): query and results
3. [Tools](https://modelcontextprotocol.io/specification/2025-11-25/server/tools): calls and responses
4. [Memory](https://docs.langchain.com/oss/python/langgraph/persistence): read and write
5. [Optimization and evaluation](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

Except for tools, all of these should be controlled by that one unit. Tools are the exception, since every developer out there creates his own, although this could spin out of control, for a reason I will come back to.

As in aviation, since I recently started to learn the theory of it, we need to have a manoeuvre to avoid spinning out of control, something we can do when things are wildly wrong. This is your small team.

> A quick note about the harness, honestly, its weight is changing. A year or two ago the harness was the fundamental piece, the thing that made a mediocre model usable. With much better models, it is not as precise and not as fundamental as it was before. The model forgives more now. What matters more every month is knowing what to build. Direction over scaffolding. However, spending is starting to be meaningful, now that everyone keeps running out of credits.

What this unit is really building is an interface. An [ABI](https://en.wikipedia.org/wiki/Application_binary_interface), an [FFI](https://en.wikipedia.org/wiki/Foreign_function_interface), a set of methods that any other team can use without asking permission each time. If another team needs to ask the unit to ship their feature for them, the interface failed.

## Software is a living organism

Software is not a building you finish. It is a living organism. It grows in places you did not plan, it gets sick in places you did, and it changes every time someone touches it. If you stick everyone to their own problems and tools, they will be building a shining new chair, when in reality you want them to build a better house with normal chairs.

Christopher Alexander saw this in buildings long before we saw it in code. In [A Pattern Language](https://en.wikipedia.org/wiki/Design_patterns) (1977) he wrote:

> "Each pattern describes a problem that occurs over and over again in our environment, and then describes the core of the solution to that problem, in such a way that you can use this solution a million times over, without ever doing it the same way twice."

He meant something closer to a language for a living thing. That is what a platform is, when it works: a small set of patterns, owned by someone, that everyone else can use a million times without doing it the same way twice. This is your [tiger team](https://en.wikipedia.org/wiki/Tiger_team).

## Specialist precision

The rest of the organization should be organized in micro-teams of two. Small enough to know their domain in detail, small enough to move, or rotate if they do not work well together. Shape a team as product direction and engineering [pulsion](https://encyclopedia.arabpsychology.com/drive/).

Their job is to iterate on their problems from customers inside the platform, not to build a platform of their own. They suggest. They test in their context. They push back when a pattern does not fit their problem. But they do not create their own memory, their own retrieval, their own eval stack on the side. The moment every micro-team builds its own version, you no longer have a product. You have five products arguing with each other.

The platform unit is the owner here, and the sole responsible for what the agent says and does. That responsibility cannot be shared, because shared responsibility is how a wrong answer in the chat becomes nobody's problem. The micro-teams iterate. The unit decides, ships, and answers for it.

A ticket for a feature is not done when the button works. It is done when the agent can do it too, in the way the domain team designed it, through the tools the unit provides.

## Teams are people. Agents are people too, kind of

None of this works if you treat teams as machines.

Cat Hicks makes this point with data in [The Psychology of Software Teams](https://www.honeycomb.io/blog/cat-hicks-psychology-of-software-teams) (2026). Treating developers as interchangeable units, brains in jars, breaks the collaboration that makes software work in the first place. Teams are people. People have goals, and those goals cannot be mechanical. A person does not only close tickets. They learn, they get blocked, they care about one problem more than another, and that caring is usually where the good work comes from.

An agent has a context instead of a mood, memory instead of experience, tools instead of hands. Give it a bad context and it will have a bad day. Give it no direction and it will still produce something, which is worse than having a low performer in your team.

The difference, and it is not a small one, is that an agent will never push back and say the direction is wrong. A person will, if you let them. That is another reason the owner has to be a person, a specific one, and not a process.

## One team to rule them none

In a normal software org, ownership is simple. A team builds feature X, the team owns feature X.

Agents break that a little.

Imagine you are on the team that builds feature X. A customer now wants X available in the chat. In the old setup, who does that work? The small unit in the middle. They did not build X, they do not own X, but they are now responsible for X inside the agent. Multiply that by every feature in the product and that unit becomes a bottleneck with a lot of surface area and very little depth.

In the setup I am proposing, the micro-team does the domain work. If you are building a feature, you also include it in the agent, in the way the platform allows you to. The unit owns the shape, the standards, and the final responsibility for what the agent says. Your team owns what your feature does inside that shape.

One team to rule them none. Direction without a bottleneck, and a name to go to when something goes wrong.

## Conclusion

Basically, what I am seeing work a lot nowadays, for the sake of velocity, is:

- One unit, one or two people, owns the direction. It builds and owns the platform: data control, retrieval, memory, evaluation, guardrails, and the patterns everyone else uses.
- That unit is the sole responsible for what the agent says and does. Not the micro-teams, not the model provider, not a shared channel.
- Micro-teams of two own their domains. They iterate on their tools inside the platform, suggest changes, and include their features in the agent as part of building them.
- Nobody builds a parallel platform. Suggestions are welcome.
- Treat both sides as alive. Teams are people with goals that are not mechanical, and agents, kind of people too, will follow whatever direction, or lack of it, you actually give them.

A real roadmap is what your business needs, not what your engineers want to build.
