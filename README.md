# Receptive

Receptive is a toolkit that will help you add behavior to your existing, server-generated HTML. It's not intended for single-page-application but rather about taking care of specific DOM nodes.

This is perfect for you if:

- **you already generate all your views from the server** (and don't want to throw everything away following the latest JavaScript fad)
- **you need your site to work without JavaScript** for SEO or any other reasons
- **you have a bunch of jQuery stuff around** and always wanted to organize it properly
- **you like Ruby** and don't want to get caught by all the subtle quirks of JavaScript


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'receptive'
```

And then execute:

    $ bundle


## How it works

Just keep your HTML as it is:

```html
<div class="hello-world">
  <input type="text">
  <button>Greet</button>
  <span class="output"></span>
</div>
```

Then write a view with a reference to it:

```rb
class HelloWorld
  extend Receptive::View
  self.selector = ".hello-world"

  on(:click, 'button') do |event|
    @greeting_text = find('input').text
    render!
  end

  def self.render
    find('.output').text = @greeting_text
  end
end
```

Read on in the [handbook](./HANDBOOK.md)

## Other features

- script[async] compatible
- pjax/turbolinks compatible


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elia/receptive.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
