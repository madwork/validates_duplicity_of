require 'validates_duplicity_of'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: File.dirname(__FILE__) + "/validates_duplicity_of.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'

RSpec.configure do |config|
  config.after :each do
    Post.delete_all
  end
end