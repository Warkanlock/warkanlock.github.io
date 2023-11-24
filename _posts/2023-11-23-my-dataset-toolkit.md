---
layout: post
title: "My essential toolkit for local data manipulation"
description: "Exposing my personal data toolkit"
date: 2023-11-23 12:00:00 -0300
author: "Ignacio Brasca"
categories: opinion
image: "https://blog.ignaciobrasca.com/img/posts/random/pic-14.jpeg"
---

## Introduction

Handling and analyzing CSV files is a common task in data processing and analytics. This blog post delves into several powerful tools and methodologies for manipulating CSV files (huge!). 

*Imagine this situation*: After a few conversations with a bunch of data providers, you decided to buy a dataset from one; after the initial chat you received an email saying “Hey, this is the data you just bought”, immediately, you find yourself with a 3GB CSV file on your server waiting there to be consumed.

After a bunch of hours trying a different software (Excel, Hex Fiend, etc) you realized: you cannot play with this data manually, you need to bring a new tool to your workbench.

So, when we're testing and playing around with data, we tend to imagine that these files are small enough to be easily manipulated through any software we use daily. We also rely on remote services where we store the data (looking at you, Google Workspace!) or even queries we do against our servers (this being Postgresql, even an API exposing this file in chunks), **although doing it directly on your local environment actually makes a lot of more sense than doing it remotely**. 

Here's why:

1. **It’s faster**: Latency is a thing you don’t need to deal with. Nowadays, computers tend to have an incredible capability of handling millions of operations per second, so you don't have to wait for data to be sent over the internet or avoid rate limits. You get results quicker, which is great when you're testing things out or just exploring the data you just received.
2. **It’s cheaper**: You don't have to pay for online services to process your data. Using your own computer is free.
3. **Works Anywhere**: You can explore your data even if you don't have an internet connection.
4. **It’s just a playground:** You don’t deal with services, credentials, API restrictions, or even resources. You just run the command and wait for a couple of milliseconds.

With these advantages in mind, let's dive into it

## Table of Contents
1. `csvtools`
	- `csvcut`
	- `csvstat`
	- `csvstack`
	- `csv2sql`
2. `sqlite` for CSV Data
3. unix pipes
4. `zq` tool for working with structured data


## 1. `csvtools` - swiss army knife for CSV files

> A little bit slower than the other alternatives

`csvkit` is a toolkit that greatly simplifies working with CSV files. It has a bunch of useful commands that help you visualize the data you are dealing with.

### csvcut

**Purpose**: To selectively keep or remove columns from a CSV file.

**Example**:

Consider an `employees.csv` file. To exclude the `email` column, use:

```bash
csvcut -c -email employees.csv
```

### csvstat

**Purpose**: Generates comprehensive statistics for each CSV column.

**Example**:

Running `csvstat` on `employees.csv`:

```bash
csvstat employees.csv
```

This command outputs detailed statistics like mean, max, and min for each column.

### csvstack

**Purpose**: Merges multiple CSV files with identical columns into one.

**Example**:

To combine `employees1.csv` and `employees2.csv`:

```bash
csvstack employees1.csv employees2.csv > employees_combined.csv
```

### csv2sql

**Purpose**: Converts CSV files into SQL tables.

> Note: this is command is a shortcut for the next tool we discuss in this blog post

**Example**:

For `employees.csv`:

```bash
csvsql --table=employees --db sqlite:///employees.db --insert employees.csv
```

This creates a SQLite database `employees.db` and inserts the CSV data into an `employees` table.


## 2. `sqlite` for CSV Data

SQLite offers native support to read CSV files, providing an efficient way to import and manipulate CSV data within a database context.

**Example**:

Importing `employees.csv` into SQLite:

```bash
sqlite3 .mode csv .import employees.csv employees
```

>Note: You will need sqlite3 to run this command but it’s the most flexible one of this list


## 3. unix pipes

Unix pipes can present a really straightforward way to deal with files, particularly useful for merging or querying it.

### Joining two files

```bash
cat file1.csv file2.csv | awk 'BEGIN { FS=OFS="," } { print $1,$2,$3 }' > joined_file.csv
```

### Appending two files

```bash
cat file1.csv file2.csv > file_total.csv
```

## 4. `zq` as my personal favorite

`zq` excels in processing various data formats, including CSV and JSON, making it a robust tool for quick data analysis. It’s part of the toolset provided by https://zed.brimdata.io

Awesome to deal with huge JSON files or even CSV we want to convert to a more structured format.

### Example: Data Filtering and Preview

Using `zq` to filter and view data from a CSV file:

```bash
zq -i csv -Z 'total_aum_analysed>0' sfdr-2023-10-05.csv
```

> This command sequence filters records with `total_aum_analysed > 0` and displays the first few records.

## Conclusion

The tools and techniques discussed are essential for anyone dealing with massive CSV datasets (or even different formats). 

From simple column manipulation to complex data joining and querying, these tools allow us to efficiently handle a wide range of data processing tasks without relying on external services or tools. 

Whether you're a data analyst, developer, or researcher, mastering these tools can significantly enhance your data manipulation capabilities. It could allow you to discover a new world regarding data that (at least me) never considered before local data manipulation.

## Left aside 

In this guide, I've focused on tools you can use on your computer. I chose not to include cloud services or big-name data providers for a few simple reasons:

1. **Cost**: Many of these services charge money (even on testing suites!), which can add up, especially if you're working with a lot of data or exploring what you have received.

2. **Complexity**: Some of these tools can be pretty complicated to set up if you don’t have an infra team. I wanted to keep things straightforward and easy to follow.

3. **Privacy**: Using external services often means sending your data online. I wanted to avoid privacy worries by keeping everything on your computer.

4. **Internet Dependence**: These services usually need a good internet connection, which you might only sometimes have.

So, I stuck to local tools to make things simpler, cheaper, and especially useful if you're exploring your datasets or trying things out.