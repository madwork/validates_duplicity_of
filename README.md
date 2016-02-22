# validates_duplicity_of

[![Build Status](https://img.shields.io/travis/madwork/validates_duplicity_of.svg)](https://travis-ci.org/madwork/validates_duplicity_of)
[![Gem](https://img.shields.io/gem/v/validates_duplicity_of.svg)](https://rubygems.org/gems/validates_duplicity_of)

ActiveRecord (>= 3.2) callback which handle the name duplication in your model with ease.
Ruby 2 only!

**Example:**

Untitled File > Untitled File (1) > Untitled File (2) ...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validates_duplicity_of'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validates_duplicity_of

## Usage

Use the method `validates_duplicity_of` with an attribute in your Rails model. The scope is optional.

```ruby
class Post < ActiveRecord::Base
  validates_duplicity_of :name
end

post = Post.create name: "Foo"
post.name
=> "Foo"

post = Post.create name: "Foo"
post.name
=> "Foo (1)"

class Note < ActiveRecord::Base
  validates_duplicity_of :title, scope: :user_id
end

note = Note.create title: "Bar", user_id: 1
note.title
=> "Bar"

note = Note.create title: "Bar", user_id: 1
note.title
=> "Bar (1)"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madwork/validates_duplicity_of.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
