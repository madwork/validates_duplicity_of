require 'spec_helper'

describe "validates_duplicity_of" do
  before(:each) { Post.create name: "New name" }

  context "without scope" do
    it "should update name if post already exists" do
      10.times do |index|
        post = Post.create name: "New name"
        expect(post.name).to eq "New name (#{index + 1})"
      end
    end

    it "should not update name if post as the same name" do
      post = Post.create name: "New name"
      expect(post.name).to eq "New name (1)"
      post.update name: "New name (1)"
      expect(post.name).to eq "New name (1)"
    end

    it "should update name with last index" do
      Post.create name: "New name (5)"
      post = Post.create name: "New name"
      expect(post.name).to eq "New name (6)"
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
end