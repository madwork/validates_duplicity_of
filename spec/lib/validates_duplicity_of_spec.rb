require 'spec_helper'

describe "validates_duplicity_of" do
  context "without scope" do
    before(:each) { Post.create name: "New name" }
    after(:each)  { Post.delete_all }

    it "should update name if post already exists" do
      10.times do |index|
        post = Post.create name: "New name"
        expect(post.name).to eq "New name (#{index + 1})"
      end
    end

    it "should update name with last index" do
      Post.create name: "New name (5)"
      post = Post.create name: "New name"
      expect(post.name).to eq "New name (6)"
    end

    it "should not update name if post as the same name" do
      post = Post.create name: "New name"
      expect(post.name).to eq "New name (1)"
      post.update_attributes name: "New name (1)"
      expect(post.name).to eq "New name (1)"
    end

    it "should update name with already indexed name" do
      post = Post.create name: "New name"
      expect(post.name).to eq "New name (1)"
      10.times do |index|
        post = Post.create name: "New name (1)"
        expect(post.name).to eq "New name (1) (#{index + 1})"
      end
    end
  end

  context "with scope" do
    before(:each) do
      Note.create title: "New title", user_id: 1
      Note.create title: "New title", user_id: 2
    end
    after(:each)  { Note.delete_all }

    it "should update title if note already exists" do
      10.times do |index|
        note = Note.create title: "New title", user_id: 1
        expect(note.title).to eq "New title (#{index + 1})"
        note = Note.create title: "New title", user_id: 2
        expect(note.title).to eq "New title (#{index + 1})"
      end
    end

    it "should update title with last index" do
      Note.create title: "New title (5)", user_id: 1
      note = Note.create title: "New title", user_id: 1
      expect(note.title).to eq "New title (6)"
      Note.create title: "New title (10)", user_id: 2
      note = Note.create title: "New title", user_id: 2
      expect(note.title).to eq "New title (11)"
    end
  end
end