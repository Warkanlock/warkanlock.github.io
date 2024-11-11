---
layout: post
title: "Exploring SQLite with Go using the C"
description: "Learn how to integrate SQLite with Go using the C API, focusing on key operations like opening and closing the database, preparing statements, and binding parameters."
date: 2024-11-11
author: "Ignacio Brasca"
categories: programming, study-notes
image: "https://blog.ignaciobrasca.com/img/gallery/i00056.jpg"
---

SQLite, a lightweight, self-contained SQL database engine, is a popular choice for embedded applications due to its simplicity and minimal setup requirements. In Go, working directly with SQLite’s C API offers low-level control and can be ideal for those who need efficient, fine-grained database handling.

In this post, we’ll explore how to integrate SQLite with Go using the C API, focusing on key operations like opening and closing the database, preparing statements, and binding parameters. Our code will be in line with what you see in the screenshot: a sample Go project leveraging `cgo` to work with SQLite’s C interface.

## Table of Contents

1. Project Setup
2. Setting Up `cgo` for SQLite
3. Core Database Functions in Go
4. Example Usage
5. Testing the Code
6. Conclusion

---

## 1. Project Setup

In the structure bellow, we have a Go project organized with folders and a few Go source files (`sqlite3.go`, `sqlite3_test.go`, etc.). If you’re following along, create a similar project structure. For instance:

> Note: I'm creating the following folder structure for the sake of practicality. You can adapt it to your needs.

```plaintext
mysqlite/
├── bin/
├── src/
│   ├── sqlite3.go
│   ├── sqlite3_test.go
├── .gitignore
└── main.go
```

Here, `sqlite3.go` will contain our primary SQLite interactions, while `sqlite3_test.go` will handle tests for those interactions.

## 2. Setting Up cgo for SQLite

To work directly with the C API of SQLite in Go, we use cgo. cgo allows Go to call C libraries and functions, letting us leverage SQLite’s powerful low-level functions.

In your Go file, add the following import block to enable cgo:

```go
/*
#cgo CFLAGS: -I/usr/local/include
#cgo LDFLAGS: -L/usr/local/lib -lsqlite3
#include <sqlite3.h>
#include <stdlib.h>
*/

import "C"
import (
    "errors"
    "unsafe"
)
```

This configuration includes SQLite’s headers and links the SQLite library so we can call its functions. The specific paths (-I and -L) may vary based on your system setup.

## 3. Core Database Functions in Go

Now, let’s dive into the main functions, using the code in `sqlite3.go` as a guide.

**Opening and Closing the Database**

A fundamental operation is opening and closing the SQLite database. Here’s a function to close the database:

```go
func (db *C.sqlite3) Close() error {
    rc := C.sqlite3_close(db)
    if rc != C.SQLITE_OK {
        return errors.New("error closing sqlite3 database")
    }
    return nil
}
```

This function calls [sqlite3_close](https://www.sqlite.org/c3ref/close.html) from the C library. We use an if statement to handle errors, returning a Go error if closing fails.

**Preparing SQL Statements**

The next step is preparing SQL statements, which sets up the database to execute queries. This is handled by [sqlite3_prepare_v2](https://www.sqlite.org/capi3ref.html#sqlite3_prepare) in the C API:

```go
func Prepare(db *C.sqlite3, query string) (*C.sqlite3_stmt, error) {
    cQuery := C.CString(query)
    defer C.free(unsafe.Pointer(cQuery))

    // define the statement
    var stmt *C.sqlite3_stmt

    rc := C.sqlite3_prepare_v2(db, cQuery, -1, &stmt, nil)
    if rc != C.SQLITE_OK {
        return nil, errors.New("error preparing sqlite3 database")
    }
    return stmt, nil
}
```

The function takes a SQL query as a string, converts it to a CString, and then calls [sqlite3_prepare_v2](https://www.sqlite.org/capi3ref.html#sqlite3_prepare). Notice the defer statement to free the C string after the function finishes.

**Binding Parameters to Queries**

When you need to pass parameters to a query, SQLite provides binding functions for different data types. For example, let’s bind an integer parameter:

```go
func BindInt(db *C.sqlite3, stmt *C.sqlite3_stmt, name string, v int) error {
    parameterCount := C.sqlite3_bind_parameter_count(stmt)
    if parameterCount == 0 {
        return errors.New("sqlite3 database has no parameter")
    }

    index := C.sqlite3_bind_parameter_index(stmt, C.CString(name))
    rc := C.sqlite3_bind_int(stmt, index, C.int(v))
    if rc != C.SQLITE_OK {
        return fmt.Errorf("error binding int: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    return nil
}
```

In this example:

- [sqlite3_bind_parameter_index](https://www.sqlite.org/capi3ref.html#sqlite3_bind_parameter_index) finds the index of the named parameter.

- [sqlite3_bind_int](https://www.sqlite.org/capi3ref.html#sqlite3_bind_int) binds the integer value to the specified index.

Similarly, let’s bind a text (string) parameter:

```go
func BindText(db *C.sqlite3, stmt *C.sqlite3_stmt, name string, v string) error {
    parameterCount := C.sqlite3_bind_parameter_count(stmt)
    if parameterCount == 0 {
        return errors.New("sqlite3 database has no parameter")
    }

    index := C.sqlite3_bind_parameter_index(stmt, C.CString(name))
    cValue := C.CString(v)
    defer C.free(unsafe.Pointer(cValue))

    rc := C.sqlite3_bind_text(stmt, index, cValue, C.int(len(v)), C.SQLITE_TRANSIENT)
    if rc != C.SQLITE_OK {
        return fmt.Errorf("error binding text: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    return nil
}
```

Binding text parameters is similar to integers, but here we use [sqlite3_bind_text](https://www.sqlite.org/capi3ref.html#sqlite3_bind_text) and handle memory management by freeing `cValue` after binding.

## 4. Example Usage

With these foundational functions, we can now use our SQLite library. Here’s a practical example demonstrating database initialization, inserting data, and querying it.

**Main Program in main.go**

```go
package main

import (
    "fmt"
    "log"
    "unsafe"
    "mysqlite/src" // import your custom library
)

func main() {
    // Open the database
    var db *C.sqlite3
    if rc := C.sqlite3_open(C.CString("example.db"), &db); rc != C.SQLITE_OK {
        log.Fatalf("Can't open database: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    defer src.Close(db)

    // Create a table
    stmt, err := src.Prepare(db, "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT)")
    if err != nil {
        log.Fatal(err)
    }
    C.sqlite3_step(stmt)
    C.sqlite3_finalize(stmt)

    // Insert a user
    stmt, err = src.Prepare(db, "INSERT INTO users (name) VALUES (?1)")
    if err != nil {
        log.Fatal(err)
    }
    defer C.sqlite3_finalize(stmt)

    if err := src.BindText(db, stmt, "?1", "Ruben"); err != nil {
        log.Fatal(err)
    }
    if rc := C.sqlite3_step(stmt); rc != C.SQLITE_DONE {
        log.Fatalf("Error inserting data: %v", C.GoString(C.sqlite3_errmsg(db)))
    }

    // Query the user
    stmt, err = src.Prepare(db, "SELECT id, name FROM users")
    if err != nil {
        log.Fatal(err)
    }
    defer C.sqlite3_finalize(stmt)

    for C.sqlite3_step(stmt) == C.SQLITE_ROW {
        id := C.sqlite3_column_int(stmt, 0)
        name := C.GoString((*C.char)(unsafe.Pointer(C.sqlite3_column_text(stmt, 1))))
        fmt.Printf("User: %d, Name: %s\n", id, name)
    }
}
```

### 4.1 Explanation

1. **Opening the Database**

We open example.db using sqlite3_open, initializing a database connection. If it fails, an error message is logged, and the program stops. The defer `db.Close()` ensures the database is closed when the program finishes.

2. **Creating the Table**

Using Prepare, we create a users table with an integer id and a name field. After preparing the statement, we execute it with sqlite3_step and finalize it with [sqlite3_finalize](https://www.sqlite.org/capi3ref.html#sqlite3_finalize) to ensure it’s cleaned up.

3. **Inserting a User**

We prepare an INSERT INTO statement to add a user. Here, we bind a name value (“Ruben”) to the SQL parameter `?1`. After binding, we execute the insert using [sqlite3_step](https://www.sqlite.org/capi3ref.html#sqlite3_step) and check for errors.

4. **Querying the User**

We prepare a `SELECT` statement to fetch all users. For each row returned by [sqlite3_step](https://www.sqlite.org/capi3ref.html#sqlite3_step), we retrieve the id and name columns and print each result to the console.

## 5. Testing the Code

Testing database interactions can be tricky, so we’ll create a small, isolated test database for each test case to keep everything clean. In this file, we’ll test the main functionalities: `creating tables, inserting data, querying data, and handling errors`.

```go
package src

import (
    "testing"
    "unsafe"
    "C"
)

// TestOpenAndCloseDatabase tests opening and closing the database connection.
func TestOpenAndCloseDatabase(t *testing.T) {
    var db *C.sqlite3
    if rc := C.sqlite3_open(C.CString(":memory:"), &db); rc != C.SQLITE_OK {
        t.Fatalf("Failed to open database: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    if err := db.Close(); err != nil {
        t.Fatalf("Failed to close database: %v", err)
    }
}

// TestCreateTable tests creating a table in the database.
func TestCreateTable(t *testing.T) {
    var db *C.sqlite3
    if rc := C.sqlite3_open(C.CString(":memory:"), &db); rc != C.SQLITE_OK {
        t.Fatalf("Failed to open database: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    defer db.Close()

    stmt, err := Prepare(db, "CREATE TABLE test (id INTEGER PRIMARY KEY, name TEXT)")
    if err != nil {
        t.Fatalf("Failed to prepare create table statement: %v", err)
    }
    if rc := C.sqlite3_step(stmt); rc != C.SQLITE_DONE {
        t.Fatalf("Failed to create table: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    C.sqlite3_finalize(stmt)
}

// TestInsertAndQuery tests inserting a row and then querying it from the database.
func TestInsertAndQuery(t *testing.T) {
    var db *C.sqlite3
    if rc := C.sqlite3_open(C.CString(":memory:"), &db); rc != C.SQLITE_OK {
        t.Fatalf("Failed to open database: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    defer db.Close()

    // Create a table
    stmt, err := Prepare(db, "CREATE TABLE test (id INTEGER PRIMARY KEY, name TEXT)")
    if err != nil {
        t.Fatalf("Failed to prepare create table statement: %v", err)
    }
    C.sqlite3_step(stmt)
    C.sqlite3_finalize(stmt)

    // Insert a row
    stmt, err = Prepare(db, "INSERT INTO test (name) VALUES (?1)")
    if err != nil {
        t.Fatalf("Failed to prepare insert statement: %v", err)
    }
    if err := BindText(db, stmt, "?1", "Ruben"); err != nil {
        t.Fatalf("Failed to bind text parameter: %v", err)
    }
    if rc := C.sqlite3_step(stmt); rc != C.SQLITE_DONE {
        t.Fatalf("Failed to insert data: %v", C.GoString(C.sqlite3_errmsg(db)))
    }
    C.sqlite3_finalize(stmt)

    // Query the inserted row
    stmt, err = Prepare(db, "SELECT id, name FROM test")
    if err != nil {
        t.Fatalf("Failed to prepare select statement: %v", err)
    }
    defer C.sqlite3_finalize(stmt)

    found := false
    for C.sqlite3_step(stmt) == C.SQLITE_ROW {
        id := C.sqlite3_column_int(stmt, 0)
        name := C.GoString((*C.char)(unsafe.Pointer(C.sqlite3_column_text(stmt, 1))))
        if id == 1 && name == "Ruben" {
            found = true
            break
        }
    }
    if !found {
        t.Fatal("Expected row not found in query result")
    }
}
```

To run the tests in your project, execute:

```bash
go test ./src
```

The command itself will look for `_test.go` files on your directory and run the tests defined in them.

## 6. Conclusion

As a practical & informative example, this article can help you out to understand a bit more in depth what's going on under the hood of a lot of libraries out there. However, there's a bunch of other integrations that doesn't rely at all in `cgo`, such as:

- [modernc.org/sqlite](https://pkg.go.dev/modernc.org/sqlite)

This library is a direct port of `sqlite` to Go, and it's a great alternative if you want to avoid `cgo` and still have a good performance.

## References

- [SQLite C Interface](https://www.sqlite.org/c3ref/intro.html)
- [cgo - Go Blog](https://go.dev/blog/cgo)
- [modernc.org/sqlite](https://pkg.go.dev/modernc.org/sqlite)
