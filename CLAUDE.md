# warkanlock.github.io

Personal Jekyll blog at https://blog.ignaciobrasca.com.

## Ship rule

After making any changes (posts, pages, CSS, config), always run:

```
make ship
```

This builds the site, commits everything including `_site/`, and pushes to `master`. Never skip this step — the live site won't reflect your changes until `_site/` is rebuilt and pushed.
