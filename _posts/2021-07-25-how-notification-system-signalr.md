---
layout: post
title:  "How to build a real-time notification system using SignalR Core"
date:   2021-07-25 12:00:00 -0300
categories: jekyll update
---

## How to build a real-time notification system using SignalR Core

First of all, if you don’t know this world and when you saw the title said something like: *WTF in the world is SignalR?*

## Quick Introduction
>  ASP.NET Core SignalR is an open-source library that simplifies adding real-time web functionality to apps. Real-time web functionality enables server-side code to push content to clients instantly.

**Source**: [https://docs.microsoft.com/en-us/aspnet/core/signalr/introduction](https://docs.microsoft.com/en-us/aspnet/core/signalr/introduction?view=aspnetcore-3.0)

So, thanks Microsoft for that introduction. Now I’m going to focus only in the architectural side of SignalR and why you should introduce into your project’s if you are using (or want to) a notification system in real-time.

Some technical details about SignalR Core, we have two elemental things, basic to understand functionality of the entire framework.

![A simplify diagram of SignalR workflow.](https://cdn-images-1.medium.com/max/2000/1*vKWtyilqi4U6nAydQjDsFQ.jpeg)

So, looking at picture before we could see a particular behaviour related to:

**Clients** have access to a **Client Hub** (exposed by the server) but that **Client Hub** has access (through an interface) to the **Server Hub.**

So we draw said something like this:

![](https://cdn-images-1.medium.com/max/2000/1*306PcOMtv4Rl8X6GJnd7sg.jpeg)

Every user has his single Hub Connection with his respective ID (with that ID we could establish a connection further). But multiple Client could have multiple connections, and that connections are bi-directional. If we take a look of the rectangles in the back of the picture we can see a **“Server Context”** that is the interface which allows communication between the Private Server Hub functionality and our Server in **.NET Core.**

## Clients

A client is a connection, just like that, which is created when an user try to negotiate (using Javascript) that communication. So, **in our Client view we must have to add a code that create a connection between our hub’s and users.**

## **Hubs**
>  The SignalR Hubs API enables you to call methods on connected clients from the server. ***In the server code, you define methods that are called by client. In the client code, you define methods that are called from the server.*** SignalR takes care of everything behind the scenes that makes real-time client-to-server and server-to-client communications possible.

Source: [https://docs.microsoft.com/en-us/aspnet/core/signalr/hubs](https://docs.microsoft.com/en-us/aspnet/core/signalr/hubs?view=aspnetcore-3.0)

So in mode a conclusion we have two parts of the same cake but with different flavour, in one side we have our *server functionality and in the other side our client side functionality*. Both are equivalent but not similar.

As an example **we can write some task** that you can do using server or client:

### Server functionality

 1. Store **Connections Id** related to an **User**. (we will see this further in this article)

 2. Some kind of server-side behaviour to control if an user wants to receive a notification.

 3. Create a method that send notifications or data.

### Client functionality

 1. Create a connection between a Hub and a User.

 2. Invoke a server-side method.

 3. Send data to the server.

OK, enough theory for now.

## Let’s write some code
>  First of all, this is not a tutorial of how to use SignalR so I avoid basic configuration stuffs but if you need help just leave a comment and I can help you.

We are going to create a framework that allows you to manage different kind of actions related to a notification system and you will be able to send that notification per user. ***One common problem that I saw in forums was related to send notifications to a particular user and how can we detect that***, so I will write some code related to that problem.

To begin, we can talk about our core Hub:

![](https://cdn-images-1.medium.com/max/2588/1*lsh9GTXhowhPd-80qL4V9w.png)

That’s our base code related to our notification system. We will discuss further ``IConnectionManager`` but that allows us to make Dependency Injection in order to store Connection’s ID and Client identifiers.

Now we are going to define our ``IConnectionManager`` class:

![](https://cdn-images-1.medium.com/max/2792/1*1sSSf9V8Z40_oXwstWs1Vw.png)

Once we defined our interface, we are going to implement basic functionality for Add and Remove connections and beside of that we are going to implement a simple ``GetConnections`` method which allow you to get all Connections related to a single ``Client``

![](https://cdn-images-1.medium.com/max/4096/1*95v3RV9ST8ksJ5BCJL89vg.png)

We can take a look of ``UserMap,`` this variable is used to “save” our identifier for a future use.

Then we define the follow methods:

![](https://cdn-images-1.medium.com/max/2724/1*W1X71fTGkjCksDiUhODoMA.png)

> It’s important to figure out WHY in the world we are using the statement lock and it’s because [``thread-safe``](https://docs.microsoft.com/en-us/dotnet/standard/threading/managed-threading-best-practices) access to collections, a very common mistake to avoid when you look SignalR documentation or tutorials in the web.

Later on we are going to modify class before in order to add a new method called ``GetConnectionId``.

Once we get here we are quite done. We only need to define our main method and inject by DI our ``NotificationHub``. That’s possible in **.NET Core** using our Startup class but just like every service.

![](https://cdn-images-1.medium.com/max/3028/1*rcOoeQgmBj6JqVHbd99vxA.png)

Wait, what is that class called ``HubNotificationHelper``? The answer is: our usage tool for the hub declare before. First we are going to declare the interface related to the implementation class:

![](https://cdn-images-1.medium.com/max/2588/1*zOCt0obseLF6GMoeMAfDnw.png)

Next we can take a look of the constructor of the class:

![Take a look of *IHubContext*](https://cdn-images-1.medium.com/max/4040/1*ZcYsaX51Ev_amq8GLdAQyA.png)

And our interface has a method called ``SendNotificationParallel`` in order to make everything thread-safe. So we have our main functionality for ``SendNotification``

![](https://cdn-images-1.medium.com/max/3904/1*JvIn39HZhbK-QPoDA0CWgA.png)

> Notice the parameters of ``Context.Clients``, one in the name of our socket exposed to the network and the other is the variables that we want to send, that could be any number that you want. Make sure you maintain consistency between Server Side and Client Side.

As we can look, the main functionality of this method is that line related to the await one. That line use the Hub functionality which comes from the context that is injected by DI in the constructor (take a look of the picture before of that last one).

So, the main core is implement, as you can see you can send a notification to a single user by a connectionId that comes from a method provides by the connection manager, BUT, ***Where we can set that Id?***

## Client Side

First of all, we have to define a method that will be invoke by the client to setup a identifier and save that identifier in the ConnectionManager class.

![](https://cdn-images-1.medium.com/max/3028/1*5nxk2M86yhYYRf1G-zujGg.png)

Take a look of the second parameter of ``AddConnection``. That receive a ``Context.ConnectionId,`` this ``Context.ConnectionId`` comes from internal Service Hub provides by SignalR framework.

Another thing, pay attention of ``HttpContext.Request.Query[“username”]``, this is because in the client I define THAT identifier for later *query the URL.*

So, later on (you can use whatever framework you want) I prefer to implement this using Typescript in Angular.

## Angular

We are going to define the core concept of our Client Service. I define a method call ``ManageConnection`` that receive by parameter a username and with the username we build a connection object and establish a connection through the hub.

![](https://cdn-images-1.medium.com/max/2960/1*seV-xMKV4QOgpp592rHqWg.png)

First we create an object **SignalR Hub** type (because of typescript). Then we start that connection using that url to negotiate with the Hub.

So, is done. You are now connected with the Hub. You can see in DevTools Console of any browser a message saying *“Server Notification: Connected” because we specify that in our promise.*

Later on, you can listen the socket using the connection object and the method **“on”** as you can see in the next picture.

![](https://cdn-images-1.medium.com/max/2320/1*XhZA5IZu7Dd_g2RNKPW3lA.png)

Here I define a parameter called **message** but you can define how many parameters that you want, for example:

![](https://cdn-images-1.medium.com/max/3500/1*eiJJkLf9l2kqCwtWOgLaEA.png)

## Conclusion

If you want to use SignalR to send notification to an user to can but try to implement a message broker in the middle, for example *Kafka* or *RabbitMQ*, in order to maintain scalability. I recommend to implement **Strategy Pattern**, in order to get different behaviour. We implement this with Martin Landart (@martinlandart ) and we get more versatility in the current context of the daily software development in our project.

### Special Thanks to

*Brenton Jakiel*


