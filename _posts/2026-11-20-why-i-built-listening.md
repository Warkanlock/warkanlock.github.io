---
layout: post
title: "Why I built Listening"
description: "A forgotten song at a party got me building a local-first music library for offline listening and discovery beyond Spotify."
date: 2026-11-20
author: "Ignacio Brasca"
categories: systems
image: "https://blog.ignaciobrasca.com/img/gallery/i00067.jpg"
tags:
    - music
    - sqlite
    - self-hosting
---

## Introduction

I was at a party the other day, trying to remember the name of a song while we were in the queue (the physical one). I had a vague idea of the lyrics, but I couldn't find it in my brain. Age might be a factor in this, although I had a vague memory of where it was in my Spotify library. Next thing I did: I tried to hum it to Shazam, but the background noise made it impossible. I even asked a friend who was there if they knew it, but they didn't either.

Eventually I had to open the app and search for it, not by name nor melody, but by playlist…

I knew I had gone too far as a dependency.

I'm a music lover since I was a kid, my mom is a music professor and I grew up surrounded not by the music itself but the idea that music can change one's life. I never had a large collection of it since it was quite hard to build one in rural Argentina, but still, I started to use [Ares](https://sourceforge.net/projects/aresgalaxy/), in the first place, to download it and build my own library.

This is how I started, and eventually when I jumped forward to use Spotify my brain was in complete excitement.

All the music in the world, for free, with a few ads, just for you to listen to.

My brain had to be wired in such a way that I still remember the first song I played: "Information" from [Eliot Sumner](https://en.wikipedia.org/wiki/Eliot_Sumner).

Now, going back to the situation of the song, it bothered me a lot. I had relied on my capability of recognizing and remembering artists for the sake of moods; I ended up going to Spotify to just "play anything" mode where the sense of discovery was lost. I was not able to find the song, and I was not able to find anything else that could be interesting for me.

Eventually I started to use [Discover Weekly](https://www.stuff.tv/features/7-secrets-spotifys-discover-weekly/), although functional and useful, I realized it was mostly like a "mood" of what I was listening to, and then they changed the algorithm internally and all recommendations were almost quite the same as what I was listening to on a daily basis.

The last drop on the glass was not remembering the song: Gaucho by Steely Dan. Ultra common in the area where I was working while producing music.

It bothered me enough so I said, enough... let's give it a try and make the player of my dreams. I wanted to be able to look through my own music when a title escaped me. I also wanted the freedom to wander a little. Spotify's recommendations had become the easiest way to pick the next record, and I was curious about what I was missing (and the only feature I was still using from them, apart from podcasts).

I wanted Listening to be **local-first**, and I wanted to do most of my listening offline. At home, the library and the queue live on my server. Before a trip, I can put the actual recordings on my phone. I go online when I want to hear something I haven't found yet.

![Swimmers and beach umbrellas beneath a rocky cliff](https://blog.ignaciobrasca.com/img/gallery/i00067.jpg)

## Where a song lives

So I started from the file. Say I have a FLAC of a live performance, a good one, and I put it on two playlists because it belongs to both. In Listening the recording itself lives once, stored in `collection.sqlite3` under the SHA-256 hash of the file, and both playlists point to the same recording. If I import the identical file again from another folder, it costs me no extra audio storage, the hash is already there. A different encode of the same performance is a different recording and gets its own hash. That distinction matters to me more than I expected: the library counts performances, not filenames.

![The Listening library: playlists and songs, each song marked ready or still missing its copy](https://blog.ignaciobrasca.com/img/posts/2026-11-20-why-i-built-listening/listening-library.jpg)

The library at home. Playing at the bottom: "Information" by Eliot Sumner, the first song I ever played on Spotify, as a FLAC in my own collection now.

The server tries zlib compression on what it stores and keeps the smaller representation, and when I export a playlist in Original format I get back **the exact bytes I imported**, plus an M3U8 with the tracks in order. Nothing re-encoded behind my back, nothing quietly normalized. What went in is what comes out.

The formats it accepts are the ones my collection actually comes in. Audio files can be MP3, raw AAC, FLAC, or M4A containing AAC or Apple Lossless. Playlists can be CSV, M3U, M3U8, or XSPF, and I can also bring in my Spotify account export, or connect Spotify to keep eligible playlists in sync. Of those, [M3U](https://en.wikipedia.org/wiki/M3U) is the one the system is built around: a playlist as a plain text file that any tool can write and any player can read. That was a deliberate decision. If the playlists are text, they are never trapped inside my app, and the system as a whole stays importable and exportable, always: music comes in as files, playlists come in as text, and both can leave the way they came.

An imported playlist, though, only gives me the names. To play it from my server I still need the recordings, and this is where I got strict, because the internet is full of files that are not what their names claim. For downloads, including the ones from the optional Soulseek adapter, Listening uses `ffprobe` to check that the file contains audio at all and that it meets a 192 kb/s floor. When an expected duration is available it allows a difference of up to 5.5 seconds, no more, and it checks that the title tags mean something. Two performances of the same song can have almost identical filenames.

## What happens when I press Play

At home there is a Python process on the server that keeps the queue. I choose which paired devices play it, the speakers, my phone, whatever is around, and each device decodes its own audio. Inside the house this runs over the LAN. Away from home I reach the same server over my VPN, and the queue is still there, in the state I left it.

**Original** is the default. The server stages audio from SQLite in a rolling three-track disk cache and serves HTTP byte ranges, so if I drag the playhead forward the player asks for the part it needs instead of starting over. The bitrate is whatever the original file contains. My FLACs play as FLACs.

For a smaller stream I can choose a compact profile, and there are two. AAC-LC in M4A at 192 kb/s, around 86 MB per hour, for web, Apple and Android. Opus at 128 kb/s variable bitrate, around 58 MB per hour, for Android. Those figures exclude network overhead. The cost I actually notice is the wait on the first play: if the original is already small enough and compatible, Listening sends it directly, otherwise FFmpeg finishes encoding the whole track before playback starts. The server keeps up to **2 GiB** of those encoded copies to reuse, so the second play of the same song does not pay the wait again.

The queue also tells the player what to fetch next. The web and Android players buffer **one song ahead by default**, adjustable to three, and the current song and the upcoming tracks share a 128 MiB budget. This explains one of my favorite readings in Playback Insights: halfway through a song, the network rate can drop to zero and the music carries on. All the bytes it needs are already here.

![Playback Insights: zero kilobits per second down from the room, one song buffered on the device](https://blog.ignaciobrasca.com/img/posts/2026-11-20-why-i-built-listening/listening-insights.jpg)

Playback Insights while "Information" plays: 0 kb/s down from the room, one song buffered on this device. The music is coming from the buffer, not from the network.

## Finding music outside my Spotify recommendations

The other thing I wanted back was wandering. Sometimes all I know is that I want to hear something *a little calmer than this*, and I do not have an artist or an album to type into a search box. For that there is the **mood map**: brightness runs along one axis and energy along the other, and each mood has a set of genres that I can edit. Dragging between Calm and Focused changes the odds of drawing from either set. If jazz belongs to both moods, the shuffle still gives a recording only one place in the queue, no duplicates dressed as variety.

![The mood map: five moods placed by energy and brightness](https://blog.ignaciobrasca.com/img/posts/2026-11-20-why-i-built-listening/listening-mood-map.jpg)

The mood map. Energy runs from the top down, brightness towards the right; tap to play, drag between moods to blend them.

**Radio plays on the device that tunes in**, which sounds like a small detail and changes everything at home. I can put [SomaFM's Groove Salad](https://somafm.com/groovesalad/) on in my headphones while the speakers carry on with the household queue. I can shuffle a genre from my library, tune into a 128 kb/s SomaFM MP3 feed, play a YouTube mix in the embedded player, or generate white or brown noise locally for sleeping. Live YouTube search takes a YouTube Data API key, which is fair enough, it is their index.

When I want an unfamiliar artist, the weekly **Deep Dive** uses related artists from [ListenBrainz](https://listenbrainz.org), and [MusicBrainz](https://musicbrainz.org) supplies the recording metadata. For a live show I can search the Internet Archive and open the recording at its source. [PeerTube](https://joinpeertube.org), a configured [Funkwhale](https://funkwhale.audio) server, and my own Jellyfin catalog also open their results at the source, because those recordings live in someone else's house and Listening is a guest there.

![Deep Dive: connections from Lucio Battisti to suggested artists outside the library](https://blog.ignaciobrasca.com/img/posts/2026-11-20-why-i-built-listening/listening-deep-dive.jpg)

Deep Dive: from Lucio Battisti, who is in the library, out to Francesco De Gregori and Vasco Rossi, who are not.

![The 'You know what?' panel for 'Information' by Eliot Sumner, a MusicBrainz relationship graph](https://blog.ignaciobrasca.com/img/posts/2026-11-20-why-i-built-listening/listening-you-know-what.jpg)

And the "You know what?" panel on the song that started all this: "Information", mapped through MusicBrainz. Eliot Sumner, performs as Coco, solo release *Information*, 2016. The graph is the wandering, drawn.

And I am not locked into my own players either. OpenSubsonic clients that support API keys can stream the verified recordings on my server, so the library outlives any single app I write for it.

## What goes camping

A few buffered tracks get me through a dropped connection on the train. Traveling is another problem. We will be traveling, and I will be using my [Mudita Kompakt](https://mudita.com/products/phones/mudita-kompakt/), a phone that is offline by design, so the music that comes with me needs an offline way to exist: no signal, no streaming account to fall back on. For that I want to see exactly what I am taking before I leave home, not discover it in a tent.

**Camping mode** picks 30, 60, or 90 distinct recordings, or as many as the verified library holds if it holds less. It can make up to two genre mixes and use a library shuffle for the rest. I can preview the selection and reshuffle before saving. A camping trip has a mood too. If a transfer stops halfway, it resumes with the tracks I still need instead of starting again.

In the browser, Listening saves the compact audio in [IndexedDB](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API), and I can reopen the trip offline in the same browser at the same trusted HTTPS address. On Android I can save the mixes to the phone or an SD card, or sync the catalog and the available originals into a private SQLite database on the phone and play them with the phone's own queue. Either way, the music that goes camping is a selection I made, from a library I own, and it does not phone home to ask permission.

## Conclusion

Listening is not public yet. There is no download page and no repository to clone; it lives on a server in my house and plays music for an audience of one household. I would like other people to be able to do this with their own music someday, and the design assumes it, playlists as portable files, recordings verified, nothing locked to my players. But someday is not today, and I am in no rush. For now it is mine the way the Ares folder on a computer in rural Argentina was mine, except this time I built the folder.

The song at the party was Gaucho, by Steely Dan, about as common as a song gets in the rooms where I used to produce music. It was in my library the whole time. What was missing was never the music. It was a way to look through it that was mine.
