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

I was at a party trying to put a song on. I knew exactly which one I wanted to play and had completely forgotten its name. I had to open Spotify to find out what it was.

That bothered me enough to build **Listening**. I wanted to be able to look through my own music when a title escaped me. I also wanted the freedom to wander a little. Spotify's recommendations had become the easiest way to pick the next record, and I was curious about what I was missing.

I wanted Listening to be **local-first**, and I wanted to do most of my listening offline. At home, the library and the queue live on my server. Before a trip, I can put the actual recordings on my phone. I go online when I want to hear something I haven't found yet.

![Swimmers and beach umbrellas beneath a rocky cliff](/img/gallery/i00067.jpg)

## Where a song lives

Say I have a FLAC of a live performance and put it on two playlists. In a new room, Listening stores the original in `collection.sqlite3` under the SHA-256 hash of the file. Both playlists point to the same recording. Importing an identical file from another folder costs me no extra audio storage. A different encode gets its own hash.

The server tries zlib compression and keeps the smaller representation. When I export a playlist in Original format, I get back **the exact bytes I imported**, plus an M3U8 with the tracks in order.

- **Audio files** can be MP3, raw AAC, FLAC, or M4A containing AAC or Apple Lossless.
- **Playlists** can be CSV, M3U, M3U8, or XSPF. I can also bring in my Spotify account export, or connect Spotify to keep eligible playlists in sync.

An imported playlist gives me the names. To play it from my server, I still need the recordings. For downloads, including those from the optional Soulseek adapter, Listening uses `ffprobe` to check that the file contains audio and meets a 192 kb/s floor. When an expected duration is available, it allows a difference of up to 5.5 seconds. It also checks meaningful title tags. Two performances can have almost identical filenames.

## What happens when I press Play

A Python process keeps the queue on the home server. I choose which paired devices play it, and each one decodes its own audio. At home that works over the LAN. Away from home I can reach the server over my VPN.

**Original** is the default. The server stages audio from SQLite in a rolling three-track disk cache and serves HTTP byte ranges. If I drag the playhead forward, the player can request the part it needs. The bitrate is whatever the original file contains.

For a smaller stream, I can choose a compact profile.

| Compact format | Encoding target | Approx. data per hour |
| --- | --- | --- |
| AAC-LC in M4A (web, Apple, Android) | 192 kb/s | 86 MB |
| Opus (Android) | 128 kb/s, variable bitrate | 58 MB |

Those figures exclude network overhead. The cost I notice is the wait on the first play. If the original is already small enough and compatible, Listening sends it directly. Otherwise FFmpeg finishes encoding the track before playback starts. The server keeps up to **2 GiB** of encoded copies to reuse.

The queue also tells the player what to fetch next. The web and Android players buffer **one song ahead by default**, adjustable to three. The current song and the upcoming tracks share a 128 MiB budget. This explains one of my favorite readings in Playback Insights. Halfway through a song, the network rate can drop to zero and the music carries on. All the bytes it needs are already here.

## Finding music outside my Spotify recommendations

Sometimes all I know is that I want to hear something *a little calmer than this*. On the **mood map**, brightness runs along one axis and energy along the other. Each mood has a set of genres I can edit. Dragging between Calm and Focused changes the odds of drawing from either set. If jazz belongs to both, the shuffle still gives a recording only one place in the queue.

**Radio plays on the device that tunes in.** I can put SomaFM's Groove Salad on in my headphones while the speakers carry on with the household queue. I can shuffle a genre from my library, tune into a 128 kb/s SomaFM MP3 feed, play a YouTube mix in the embedded player, or generate white or brown noise locally. Live YouTube search takes a YouTube Data API key.

When I want an unfamiliar artist, the weekly **Deep Dive** uses related artists from ListenBrainz. MusicBrainz supplies recording metadata. For a live show, I can search the Internet Archive and open the recording at its source. PeerTube, a configured Funkwhale server, and my own Jellyfin catalog also open results at the source.

I can use another player, too. OpenSubsonic clients that support API keys can stream the verified recordings on my server.

## Where I'd get the first few records

### A track from the composer

Kevin MacLeod offers *Monkeys Spinning Monkeys* as a download under **CC BY 4.0**. I checked the MP3 with `ffprobe`. It comes in at 320 kb/s with the title and artist tags already filled in. Listening indexed it straight from the download.

I'd keep the composer's credit and the license link with the file so I have both if I share it later.

- [Download Monkeys Spinning Monkeys from Kevin MacLeod](https://incompetech.com/music/royalty-free/index.html?isrc=USUAN1400011)
- [Read the CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/)

### An audience tape from the Live Music Archive

For concerts, I check the band's policy for the recording I want. Take the Grateful Dead. At the band's request, the Internet Archive offers **audience recordings for download** and **soundboard recordings for streaming only**. If I'm picking a show to take camping, I look for an audience tape.

- [Browse concerts in the Live Music Archive](https://archive.org/details/etree)
- [Read the Grateful Dead collection policy](https://archivesupport.zendesk.com/hc/en-us/articles/360004715891-The-Grateful-Dead-Collection)

### Importing those files

Once I have a folder of tagged music, I can generate a playlist from a source checkout with FFmpeg installed. Here `music/` is my folder and `First.csv` is a new filename.

```sh
mkdir -p music/Playlists
./listening music index music music/Playlists/First.csv
```

In Docker Compose, the import configuration mounts the folder read-only at `/imports`.

```sh
LISTENING_IMPORT_DIR="$(pwd)/music" docker compose \
  -f docker-compose.yml -f packaging/compose.import.yaml up -d --no-build
```

In **Settings → Sources**, I add `/imports/Playlists` and choose **Check folders**. I can then open the playlist and press Play. To try it with an empty collection, `./listening music demo demo-music` generates an eight-second track called *First light* and its own playlist.

## What goes camping

A few buffered tracks get me through a dropped connection. For a weekend away, I want to see exactly what I'm taking before I leave home.

**Camping mode** picks 30, 60, or 90 distinct recordings, or as many as the verified library holds. It can make up to two genre mixes and use a library shuffle for the rest. I can preview the selection and reshuffle before saving. If a transfer stops, it resumes with the tracks I still need.

- **In the browser**, Listening saves compact audio in IndexedDB. I can reopen the trip offline in the same browser at the same trusted HTTPS address.
- **On Android**, I can save mixes to the phone or an SD card. I can also sync the catalog and available originals into a private SQLite database, then play them with the phone's own queue.

I'd like to open-source Listening because I'd like other people to be able to do this with their own music. The next time I forget the name of a song at a party, I'd like to hand someone my phone, open the collection we brought, and find it together.
