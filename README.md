# Snotel

[![Build Status](https://travis-ci.org/firstchair-io/snotel.svg?branch=master)](https://travis-ci.org/firstchair-io/snotel)

This is a gem for a Ruby client to access SNOTEL data from the NRCS.

## Installation

Add this line to your application's Gemfile:

    gem 'snotel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snotel

## Usage

### Get all station data

```ruby
Snotel.get_station_data # => [ ... ]
```

### Daily Snowfall Data

```ruby
# Get the last day
Snotel.daily(:snowbird) # => [{:date=>"2014-09-13", :snow_water_equivalent_in=>"0.0", :change_in_snow_water_equivalent_in=>"0.0", :snow_depth_in=>nil, :change_in_snow_depth_in=>nil}]

# Get the last week
Snotel.daily(:snowbird, 7) # => [ ... ]
```

### Hourly Snowfall Data

```ruby
# Get the last 24 hours
Snotel.hourly(:lookout) # => [ ... ]

# Get the last 72 hours
Snotel.hourly(:lookout, 72) # => [ ... ]
```

## Acknowledgements

This gem is essentially an abstraction of the awesome work done by the developers for the
[powderlin.es api](http://powderlin.es/api.html): <https://github.com/bobbymarko/powderlines-api>

## Contributing

1. Fork it ( https://github.com/firstchair-io/snotel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Crafted with <3 by [John Otander](http://johnotander.com).
