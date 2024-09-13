---
layout: post
title: 'InfinityDB: A theorical ideal about a distributed storage'
description: Theorical ideas about a distributed database that can store infinite data across a set of agents.
date: 2024-09-13
author: Ignacio Brasca
categories: programming
image: https://blog.ignaciobrasca.com/img/gallery/i00002.jpg
tags:
  - notes
  - ideas
  - experiment
---

{% include latex.html %}
{% include mermaid.html %}

> This post was written as a walking thought and it's not quite well structured. I'm just trying to put my ideas into words. Come back to this blog post in a few years and see if this was right or wrong. 

## Introduction

Today before taking a walk, I observe my phone and I received a notification: you mail has been leaked. I was like, "Well, that's not good", to just get lost in my thoughts about how we store data, as a whole, today.

I've always been fascinated by how complex systems can work so well when they're made up of simple, independent parts. 

Let's take markets, for example. Each person in a market acts based on their own limited information and personal goals. They don't know everything about the market, yet the market functions efficiently—often better than if it were controlled by a central authority. The only thing they know about the market is that the market cannot be `controlled` by a single entity (or at least, it shouldn't).

This made me think about how we store data today. 

Despite all our technological advances, we still **rely heavily on centralized databases**. These are large storage systems protected by complex security measures. But they're still vulnerable to attacks that can expose huge amounts of information all at once. It struck me that maybe our approach to storing data is flawed. We tend to believe that centralizing data means better control and security, but perhaps that's not the case.

What if we took inspiration from the resilience of markets and natural systems? 

Instead of putting all our data in one place, what if we spread it across a network of independent agents? Each agent would operate on its own but still be part of a larger system.

This idea led me to think about a new way of storing data—a decentralized system I started calling **InfinityDB**.

## The Concept

Imagine walking through a busy marketplace. Vendors line the streets, each running their own small shop. They don't need a central authority to tell them how to price their goods or who to sell to. They operate based on simple principles like supply and demand. The market works well not despite being decentralized, but because of it. 

> This is not my area of expertise, but I think it's a good analogy to understand the concept moving forward.

Now, let's apply this idea to data storage. 

Think of a network of **agents**: independent units that manage data on their own. Each agent has limited capacity and can perform a few simple actions: create data, accept data from others, transfer data, negotiate exchanges, and even buy data from other agents. 

These actions are straightforward and happen within a set time, making the system efficient and predictable.

Here's how it might work:

An agent creates a piece of data—maybe a small image. This data stays in the agent's memory for a certain period ($t$). Another agent needs this data ($I$). They start a negotiation, agreeing on terms for transferring the data. There might be a small fee involved, depending on the size of the data or how difficult it is to transfer. The exchange happens directly between the agents, without any central server involved.

This agents will have rules defined by its owners, and the only way to interact with them is through a protocol defined by the network itself.

The simplicity of this system is what it makes it strong. Because data is spread out among many agents, there's no single point of failure. 

If one agent is compromised, only a small piece of data is at risk, greatly reducing the chance of a large data breach. Also, the system can grow naturally. If you need more storage or processing power, you just add more agents. Each new agent increases the network's capacity without overloading any single part.

The agents are designed to be flexible regarding the underlying storage technology. They might run on different servers, within various private networks, or under different administrative controls. The important thing is that they follow a common protocol for interacting with each other, allowing them to work together smoothly in the larger system.

## The Idea

At the core of InfinityDB concept, the idea is **autonomous agents**, interacting through defined protocols and data structures. 

### Architecture

The actual architecture of the system can be represented into two parts:

<div class="mermaid">
graph LR;
    A[Data Agent Access] --> B(InfinityDB Structure);
    B --> A;
</div>
- Data Agent Access: The interface through which users interact with the system, including creating, accepting, moving, and negotiating data.
- InfinityDB Structure: The underlying data structure used to store and manage data within the system, including chunk identifiers, types, sizes, and distribution strategies. This will be hidden for end users.

### InfinityDB Structure

In the system here presented, data is stored in small, manageable chunks. Each chunk has a unique identifier and includes metadata such as chunk type, size, sequence number, and distribution strategy. The structure leverages identifiers to track individual pieces, chunk types and sizes for efficient handling, part numbers for ordering, and a spread strategy for managing data replication across the system. The data itself is stored as a byte array, allowing flexibility in storing various content types.

This differ from the data agent access as the data agent access is the interface that the user will interact with, the InfinityDB structure is the internal structure that the system will use to store and manage data. Think of it as the internal structure of a traditional database system, which is hidden to non-administrative users.

#### Data Structures

Data is managed in chunks with associated metadata for efficient handling and distribution.

```rust
struct DataObject {
    content: Vec<u8>,
}

struct InfinityDBChunk {
    identifier: u64,    // Unique ID for the chunk
    chunk_type: usize,  // Type identifier for the chunk
    chunk_size: usize,  // Size of the chunk in bytes
    part_number: usize, // Sequence number in a series
    spread: i32,        // Distribution strategy indicator
    data_type: i32,     // Specifies the data format
    data: Vec<u8>,      // Actual data payload
}
```

### Data Agent Access

- An $agent$, in this architecture, will allow and restrict the transpass of informaton.
- This $agent$, **will** charge in case of a transaction, a fee (could be zero).
    - This fee will be proportional to the amount of information can handle.
- More information transit through an $agent$, more restrictions this $agent$ **can** impose.
- This $agent$, **will** have: an *identifier*, a set of *possible actions* ($n$) and *how much information can accept* ($I$) and for how long ($t$). 

Each of this rules should be defined by the agent itself, and the agent should be capable of persist alone the burden of the system according to it's own definitions.

```rust
struct Agent { 
    identifier: u64,
    actions: Vec<Action>,
    information: f64,
    time: f64,
}
```

The theorical system workflow will be just the sum of the individual workflows of each agent. A `workflow` is defined as the set of actions that can be performed by an agent in a given time.

following the same set of rules used to stablish the network:

1. Each agent should have a finite set of actions
2. Each action should finite in $t$ and pure
3. Each agent should have a finite amount of information to handle
4. Each agent can charge zero or more as fee for the action performed
5. Each agent should paid with information to perform an action
6. Each agent should starts with a finite amount of information allocated
7. Each agent $A$ can perform the following actions: `create`, `accept`, `move`, `negotiate`, `buy`

#### Interface

Agents perform specific actions defined by an interface. In Rust-like pseudocode, an agent's capabilities might be outlined as:

```rust
trait Agent {
    // Creates new data within the agent
    fn create_data(&mut self, data: DataObject) -> bool;

    // Allows the agent to accept data from others for a fee
    fn accept_data(&mut self, data: DataObject, fee: f64) -> bool;

    // Transfers data to another agent
    fn transfer_data(&mut self, recipient_id: u64, data: DataObject, fee: f64) -> bool;

    // Puts data up for negotiation in the network
    fn negotiate(&mut self, data: DataObject, fee: f64) -> NegotiationResult;

    // Purchases data from another agent based on a negotiation ID
    fn buy_data(&mut self, negotiation_id: u64) -> Option<DataObject>;
}
```

### Communication and Protocols

Agents communicate over a network. Data transfers and negotiations are conducted through standardized protocols to ensure interoperability and security.

### Distributed Storage Mechanism

The `spread` parameter in `InfinityDBChunk` determines how data chunks are distributed across the network. This facilitates redundancy. For example, a spread value of 1 might mean the chunk is stored on one agent, while a spread value of 3 might mean the chunk is stored on three different agents.

### Redundancy and Data Recovery

Leveraging techniques from distributed systems like Distributed Hash Tables (DHTs) and erasure coding (such as *Reed-Solomon*, maybe), the system ensures that data can be recovered even if some agents fail. This redundancy is critical for maintaining data integrity in a decentralized environment.

## Conclusion

Ideas like this come to my head daily which are completely nonsense, but this about data storage hit home particulary, since I believe something else can be done by using decentralized agents challenges. I suggests that by giving up some centralized control, we can achieve greater resilience and scalability for our privacy.  This doesn't mean getting rid of structure altogether but embracing a different kind of architecture—one that values simplicity, independence, and the collective strength that comes from decentralized systems.

Of course, building such a system isn't without challenges. There are issues of data consistency, synchronization, and trust between agents that need careful solutions. But these problems are not impossible to overcome. In many ways, they're similar to the challenges we faced when building the internet itself—a decentralized network that has proven to be very robust and adaptable.

**InfinityDB** is just a theoretical idea today but it's also an invitation to think how we store and manage data. In a time when data breaches and system vulnerabilities are becoming more common, perhaps the way forward isn't tighter centralization but embracing the decentralized, independent models that have worked well in other areas. By doing this, we might unlock new levels of efficiency, security, and innovation—a hidden architecture built not on control, but on collaboration.