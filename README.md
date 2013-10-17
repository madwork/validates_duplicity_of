# validates_duplicity_of

ActiveRecord (>= 3) callback which handle the name duplication in your model with ease.
Ruby 2 only!

**Example :**

Untilted File > Untilted File (1) > Untilted File (2) …

## Installation

Add this line to your application's Gemfile:

    gem 'validates_duplicity_of'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validates_duplicity_of

## Usage

Use method `validates_duplicity_of` with attribute in your Rails model. Scope is optional.

	class Post
	  validates_duplicity_of :name, scope: :user_id
	end
	
	p = Post.create name: "Foo", user_id: 1
	p.name
	=> "Foo"
	
	p = Post.create name: "Foo", user_id: 1
	p.name
	=> "Foo (1)"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
