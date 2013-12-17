# validates_duplicity_of

[![Build Status](https://travis-ci.org/madwork/validates_duplicity_of.png)](https://travis-ci.org/madwork/validates_duplicity_of)
[![Gem Version](https://badge.fury.io/rb/validates_duplicity_of.png)](http://badge.fury.io/rb/validates_duplicity_of)

ActiveRecord (>= 3.2) callback which handle the name duplication in your model with ease.
Ruby 2 only!

**Example:**

Untitled File > Untitled File (1) > Untitled File (2) …

## Installation

Add this line to your application's Gemfile:

    gem 'validates_duplicity_of'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validates_duplicity_of

Or with security:

	$ wget http://git.io/hHL6zQ -O madwork-public_cert.pem
	$ gem cert --add madwork-public_cert.pem
	$ gem install validates_duplicity_of --trust-policy=HighSecurity

## Usage

Use method `validates_duplicity_of` with attribute in your Rails model. Scope is optional. Default callback is `before_save`.

	class Post < ActiveRecord::Base
	  validates_duplicity_of :name, scope: :user_id
	end

	p = Post.create name: "Foo", user_id: 1
	p.name
	=> "Foo"

	p = Post.create name: "Foo", user_id: 1
	p.name
	=> "Foo (1)"

	class Note < ActiveRecord::Base
	  validates_uniqueness_of :name
	  validates_duplicity_of :name, callback: :before_validation
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
