ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: true do |t|
    t.string :name
  end

  create_table :notes, force: true do |t|
    t.string :title
    t.integer :user_id
  end

  create_table :comments, force: true do |t|
    t.string :name
  end
end