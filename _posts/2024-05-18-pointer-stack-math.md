---

layout: post  
title: "Nand2Tetris: Stack Pointer Math"
description: "A brief explanation of stack pointer math in Hack assembly."
date: 2024-05-18  
author: "Ignacio Brasca"  
categories: programming  
image: "https://blog.ignaciobrasca.com/img/posts/programming/pic-10.png"  
---

After spending several days grappling with the intricacies of the stack pointer in my Hack computer, I finally decided to consolidate my understanding in a post.

This will be a concise guide, almost a cheatsheet, on how the stack operates within a [Hack computer](https://en.wikipedia.org/wiki/Hack_computer), and ideally, within your virtual machine (and your mind).

## What's the Stack?

The stack is a data structure that operates as a LIFO (Last In, First Out) mechanism. Think of it as a stack of plates: you can only take the top one, and you can only add a new plate on top.

In the Hack computer, the stack is a contiguous block of memory starting at ``RAM[0]`` and ending at ``RAM[2047]``. *(see reference at page 136 of the book)*

This, in addition with other types of memory addresses, is what makes up the Hack computer's memory.

These addresses are:

- ``RAM[0]``: the stack pointer
- ``RAM[1]`` to ``RAM[15]``: general-purpose [registers](https://en.wikipedia.org/wiki/Processor_register) (R0 to R15)
- ``RAM[16]`` to ``RAM[255]``: static variables
- ``RAM[256]`` to ``RAM[2047]``: the stack
- ``RAM[2048]`` to ``RAM[16383]``: heap

The rest of the memory is divided as follows:
- ``RAM[16384]`` to ``RAM[24575]``: screen memory map
- ``RAM[24576]``: keyboard memory map
- ``RAM[24577]`` to ``RAM[32767]``: unused segment of memory

> see more at page 93, figure 5.6 of the book

## How Does It Work?

In our computer, the stack pointer is a register that points to the next available memory address in the stack. When you push a value onto the stack, the stack pointer increments by 1. When you pop a value from the stack, the stack pointer decrements by 1.

## A Quick Example

Knowing in advance that

1. `A = value` of the address pointed to by `instruction A`.
2. `M = RAM[A]` of the memory at address `A`.
   1. The `M` will always reflect the value pointed to by the `A` value.
3. `D = value` is only a temporary register that we use to facilitate calculations.

You can also calculate arithmetic operations with these registers, however the goal of this article is to show you how to manipulate the stack and not these registers (*there is plenty of material for this on the Internet*).

Now, let's start with the example that has ``RAM[0] = 256``:

```hack
@5
D=A // D = 5

@SP // always points to RAM[0]
A=M // A = RAM[0] = 256
M=D // RAM[256] = 5

@SP // go back to RAM[0]
M=M+1 // RAM[0] = 257
```

However, in the next iteration

```hack
@10
D=A // D = 10

@SP // always points to RAM[0]
A=M // A = RAM[0] = 257
M=D // RAM[257] = 10

@SP // go back to RAM[0]
M=M+1 // RAM[0] = 258
```

In this example, we're pushing the value 5 onto the stack and incrementing the stack pointer by 1. Then, we're pushing the value 10 onto the stack and incrementing the stack pointer by 1 again.

But bear in mind, the stack pointer always points to the next available memory address in the stack however the ``@SP`` operation will always point to ``RAM[0]`` hence the value stored at ``RAM[0]`` will the address of the next available memory address in the stack.

### How does this work?

It's straightforward once you grasp this key concept: the stack pointer always points to the next available memory address in the stack. 

Thus, ``@SP`` will always point to ``RAM[0]``, but the value stored in ``RAM[0]`` will be the next available memory address in the stack.

## Conclusion

I hope this post clarifies how the stack works in the Hack computer. To me, understanding of the full mechanism of the stack pointer was a game-changer since enabled me to write more complex Hack assembly code and also understand what's going on under the hook.

Take care with *The Elements of Computing Systems* since it's a heavy lifting book that can suck you in for hours. But it's worth it.

Happy coding!
