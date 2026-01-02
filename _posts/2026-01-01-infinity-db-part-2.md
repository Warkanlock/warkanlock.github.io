———
layout: post
title: "InfinityDB: the comeback of agent storage"
description: "Walking notes on letting each agent own its storage"
date: 2026-01-03
author: "Ignacio Brasca"
categories: systems
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-22.jpeg"
tags:
- infinitydb
- distributed-systems
- agents
  ———

I keep coming back to this idea that storage should look more like a market: lots of small actors, each guarding its own corner, instead of a single vault. The last three commits pushed
that vision a bit closer to something tangible.

First, I let agents declare their own storage. It’s their choice now hence each agent theorically can emulate any storage and share information in between to decode information in between. When an agent creates or transfers data, the engine drops the chunks into that agent’s backend and keeps a placement map alongside a tiny JSON record so we remember who holds what. 

It’s a simple trick, but it means one noisy agent no longer implies everyone else is noisy too. On top of that, transfers became explicit. There’s a placement endpoint that copies selected chunks into other agents’ stores and persists the new layout. It’s not consensus or erasure coding, just a clean way to say, “this piece lives here, here, and here,” and then make it true.

The repository is now structured such as workspaces:

- `crates/infinitydb-core`: the engine and domain logic (agents, negotiations, objects, chunking, access checks). No dependencies.
- `crates/infinitydb-protocol`: wire/request/response DTOs shared by adapters (HTTP today, gRPC/CLI later).
- `crates/infinitydb-storage`: pluggable storage backends behind a trait (in-memory + SQLite for now).
- `crates/infinitydb-server`: thin HTTP adapter that maps API calls to the core engine.
- `crates/infinitydb-cli`: placeholder CLI adapter for local scripts and demos.

Now, to run the protocol I prepared a server with `cargo run -p infinitydb-server`, allowing me to emulate the protocol easily with a frontend I wrote in React.

Additionally, the sandbox prepared to emulate the protocol looks good enough to understand what's going on...

![infinitydb-sandbox](https://blog.ignaciobrasca.com/img/posts/2026-01-01-infinity-db-part-2/infinitydb-sandbox.png)
![infinitydb-sandbox](https://blog.ignaciobrasca.com/img/posts/2026-01-01-infinity-db-part-2/infinitydb-sandbox-2.png)

We can also `decode` the content easily and understand from which agent each chunk comes from:

![infinitydb-sandbox](https://blog.ignaciobrasca.com/img/posts/2026-01-01-infinity-db-part-2/infinitydb-sandbox-3.png)

Still theoretical, still rough, but with every change I believe this idea can grow into something real. 

A distributed database where each participant owns their data, and together they form a resilient, flexible market of storage.
