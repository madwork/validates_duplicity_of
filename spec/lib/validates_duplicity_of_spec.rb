require 'spec_helper'

describe "validates_duplicity_of" do
  context "without scope" do
    before { Post.create name: "New name" }
    after  { Post.delete_all }

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

    it "should keep the same index with the same name" do
      Post.create name: "New name (1)"
      post = Post.create name: "New name (2)"
      post.update_attributes name: "New name"
      expect(post.name).to eq "New name (2)"
    end

    it "should not update if name is not present" do
      Post.create name: ""
      post = Post.create name: ""
      expect(post.name).to eq ""
    end

    it "should handle invalid previous matches" do
      Post.create [{ name: "Name" }, { name: "Name (first)" }]
      post = Post.create name: "Name"
      expect(post.name).to eq "Name (1)"
    end

    it "should handle non digit matches" do
      Post.create name: "Name (first)"
      post = Post.create name: "Name"
      expect(post.name).to eq "Name"
      post.update_attributes name: "Name (first)"
      expect(post.name).to eq "Name (first) (1)"
    end
  end

  context "with scope" do
    before { Note.create [{ title: "New title", user_id: 1 }, { title: "New title", user_id: 2 }] }
    after  { Note.delete_all }

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
