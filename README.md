# ChangeBundleid

A tool to change the bundle identifier of an Xcode project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'change_bundleid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install change_bundleid

## Usage

```
Usage: change_bundleid [options]
    -p, --path PATH                  [REQUIRED] Path to the Xcode project (xcproject, not xcworkspace)
    -t, --target NAME                [REQUIRED] Project target
    -c, --conf NAME                  PProject configuration (default = Release)
    -i, --bundleid NAME              [REQUIRED] New bundle ID
    -s, --skip-plist                 Don't modify the info.plist file
    -v, --verbose                    Verbose mode
    -h, --help                       Show this message
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FutureWorkshops/ChangeBundleID.


## License

The gem is available under the terms of the [MIT License](http://opensource.org/licenses/MIT).

