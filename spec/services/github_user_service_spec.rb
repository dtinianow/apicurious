require 'rails_helper'

describe GithubUserService do

  before(:each) do
    @user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
  end

  context "#get_github_user" do
    it "returns data about the current user" do
      VCR.use_cassette("github_user_service_get_github_user") do

        github_user = GithubUserService.new(@user).get_github_user

        expect(github_user).to respond_to :login
        expect(github_user).to respond_to :avatar_url
        expect(github_user).to respond_to :name
        expect(github_user).to respond_to :following
        expect(github_user).to respond_to :followers
        expect(github_user[:login].class).to eq(String)
        expect(github_user[:avatar_url].class).to eq(String)
        expect(github_user[:name].class).to eq(String)
        expect(github_user[:following].class).to eq(Fixnum)
        expect(github_user[:followers].class).to eq(Fixnum)
      end
    end
  end

  context "#get_followings" do
    it "returns data about users that the current user follows" do
      VCR.use_cassette("github_user_service_get_followings") do

        followings = GithubUserService.new(@user).get_followings
        following = followings.first

        expect(followings.count).to eq 6
        expect(following).to respond_to :login
        expect(following).to respond_to :events_url
        expect(following[:login].class).to eq(String)
        expect(following[:events_url].class).to eq(String)
      end
    end
  end
end
