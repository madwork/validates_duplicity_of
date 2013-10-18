class Post < ActiveRecord::Base
  validates_duplicity_of :name
end

class Note < ActiveRecord::Base
  validates_duplicity_of :title, scope: :user_id
end

class Comment < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_duplicity_of :name, callback: :before_validation
end