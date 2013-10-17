class Post < ActiveRecord::Base
  validates_duplicity_of :name
end