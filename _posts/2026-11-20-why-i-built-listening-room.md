---
layout: post
title: "Why I built Listening Room"
description: "What happens to a recording between a SQLite database at home, a pair of speakers, and a phone leaving for a camping trip."
date: 2026-11-20
author: "Ignacio Brasca"
categories: systems
image: "https://blog.ignaciobrasca.com/img/gallery/i00067.jpg"
tags:
  - music
  - sqlite
  - self-hosting
---

I wanted to be able to pick a record on my laptop, play it on the speakers at home, and take it camping. What bothered me about those three fairly ordinary things was having to maintain a different collection for each one. I already know which version of a song I want. I'd like to make that decision once.

Listening Room is the music server I built around that idea. A Python process at home keeps the collection and the playback queue. The browser and the apps decode the audio on whichever devices I choose to hear it. I can pair them on the LAN or reach the room over my VPN. The interesting part was deciding which bytes each device actually needs.

![Swimmers and beach umbrellas beneath a rocky cliff](/img/gallery/i00067.jpg)

*Photo from [my gallery](/photos).*

## Where a song lives

Say I have a FLAC of a live performance and put it on two playlists. A new room stores the original in `collection.sqlite3`, keyed by the SHA-256 hash of the file. Both playlists can refer to the same recording. If I import a byte-identical copy from another folder, the database still holds one audio payload. If I bring in a different encode, it gets a different hash. The store tries zlib and keeps the compressed representation only when it saves space. I can export the exact bytes I put in, along with an M3U8 in playlist order.

The importer accepts tagged MP3, raw AAC, FLAC, and M4A files, including AAC and Apple Lossless in M4A. Playlists can come in as CSV, M3U, M3U8, or XSPF. This distinction matters if you start with years of playlists and very little audio. A Spotify account export can give the room a track list. Connecting Spotify can keep eligible playlists in sync. To play one of those tracks from my server, I still need a copy of the recording.

The room uses ffprobe to inspect the audio. For a download, the room checks for an audio stream, applies a 192 kb/s minimum, compares the duration to the expected length when available (5.5 seconds of tolerance), and checks the title when the file has a meaningful tag. The optional Soulseek adapter goes through verification too. A filename alone tells you very little about which performance somebody recorded.

## What happens when I press Play

At home I can play the original. The server stages SQLite audio in a rolling three-track disk cache and serves HTTP byte ranges, so dragging the playhead forward doesn't require fetching the beginning of the file again. In Original mode the bitrate is whatever the source file contains.

On a phone I can ask for a smaller copy. The web and Apple players offer AAC-LC in M4A at a target of 192 kb/s. Android also offers Opus at 128 kb/s VBR. An hour at those targets works out to about 86 MB and 58 MB respectively, before transport overhead. The tradeoff shows up on the first play. FFmpeg has to finish encoding the track before the server can send it. The room reuses compatible small originals and keeps up to 2 GiB of encoded copies for later requests.

The queue gives the player one piece of information a live stream doesn't have. It already knows the next song. The web and Android room players fetch complete tracks, with a 128 MiB budget for the current song and whatever fits ahead of it. The default is one song ahead and I can turn it up to three. This also explains a slightly odd reading in Playback Insights. The network rate can drop to zero halfway through a song while I can still hear it perfectly well. The bytes are already here.

## Picking something to listen to

Sometimes the only decision I want to make is *a little calmer than this*. The mood map gives me brightness on one axis and energy on the other. Each mood has an editable set of genres. Dragging between two moods changes how often the shuffle draws from each set, skipping recordings it has already picked. If jazz belongs to both Calm and Focused, the same performance still gets one place in the queue.

Radio belongs to the device. I can put on Groove Salad in my headphones while the speakers carry on with the household queue. The radio choices include genre shuffles from the library, SomaFM's 128 kb/s MP3 feeds, YouTube mixes in the embedded player, and white or brown noise generated on the device. Live YouTube search takes a YouTube Data API key.

I can also look for a recording outside the room. Public catalog results from Internet Archive, PeerTube, or a configured Funkwhale server open at the source. A private Jellyfin catalog works the same way. MusicBrainz supplies recording metadata, and ListenBrainz supplies related artists for the weekly Deep Dive. In the other direction, an OpenSubsonic player that supports API keys can connect to the room and stream its verified library.

## Where I'd get the first few records

Kevin MacLeod publishes *Monkeys Spinning Monkeys* with a download and a CC BY 4.0 license on the track page. I checked the MP3 with ffprobe. It comes in at 320 kb/s with both title and artist tags, so the room can index it as it comes from the composer. I'd keep the supplied credit and license link alongside the recording so they're handy if I share it later. [Download from the composer](https://incompetech.com/music/royalty-free/index.html?isrc=USUAN1400011) · [License terms](https://creativecommons.org/licenses/by/4.0/)

For concerts, I'd start with the Internet Archive's Live Music Archive and read the band's policy for the particular recording. The Grateful Dead collection is a good example of why. At the band's request, the Archive offers audience recordings for download and soundboard recordings for streaming only. If I want a show for the car, I pick an audience tape the Archive offers for download. [Browse live recordings](https://archive.org/details/etree) · [Grateful Dead collection policy](https://archivesupport.zendesk.com/hc/en-us/articles/360004715891-The-Grateful-Dead-Collection)

Once I have a folder of tagged music, I can generate the first playlist from a source checkout with FFmpeg installed. Here `music/` is my folder and `First.csv` is a new filename.

```sh
mkdir -p music/Playlists
./listening music index music music/Playlists/First.csv
```

With Docker Compose I point the import configuration at that folder. The extra Compose file mounts it read-only at `/imports` and tells the room where to look.

```sh
LISTENING_IMPORT_DIR="$(pwd)/music" docker compose -f docker-compose.yml -f packaging/compose.import.yaml up -d --no-build
```

In Settings under Sources, I add `/imports/Playlists` and choose **Check folders**. The local playlist now has a playable copy of the song. For an empty room, `./listening music demo demo-music` synthesizes an eight-second track called *First light* and writes its playlist.

## What goes camping

A few buffered songs will get me through a dropped connection. For a trip I want to know what's on the device before I leave. Camping mode picks 30, 60, or 90 distinct recordings from the verified library, or as many as I have. It can build up to two genre mixes and fill the rest with a library shuffle. I can look at the selection, reshuffle it, then save it. An interrupted save resumes from the tracks that finished.

The web player saves compact audio in IndexedDB. I can reopen the saved trip offline from the same browser and trusted HTTPS address. Android can write the mixes to internal storage or an SD card. It can also sync the catalog and available original audio into a private SQLite database and play it with its own queue.

This is the part that makes me want to open-source Listening Room. Someone else can build a room around a completely different collection. And if they eventually decide they'd prefer another player, an exported folder will still have their recordings and a playlist in the order they picked.
