# Feedbag app

Returns a list of feed URLs.

## Deploy

The master branch at GitHub is deployed automatically.

    git push

## Example usage

https://feedbag.herokuapp.com/?url=googleonlinesecurity.blogspot.se

## Note about gems

Gems are vendored into `vendor/cache`, you should always check in the gems when changing gems. The caching was set up with [`bundle package`](https://bundler.io/man/bundle-package.1.html).

You can use `bundle install --local` to install only from cache (e.g. you find yourself without internet connection).
