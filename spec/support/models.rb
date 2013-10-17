class Post < ActiveRecord::Base
  validates_duplicity_of :name
end

class Note < ActiveRecord::Base
  validates_duplicity_of :title, scope: :user_id
end