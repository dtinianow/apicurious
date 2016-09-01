require 'rails_helper'

describe GithubUser do
  
  it "returns attributes of the current user" do
    VCR.use_cassette("github_user_service_get_github_user") do
      user = User.create(
        uid: "1234",
        provider: "github",
        username: "dtinianow",
        name: "David Tinianow",
        token: ENV["GITHUB_TOKEN"]
      )
      github_user = GithubUser.find(user)

      expect(github_user.login).to eq "dtinianow"
      expect(github_user.name).to eq "David Tinianow"
      expect(github_user.following).to eq 6
      expect(github_user.followers).to eq 1
    end
  end

  it "returns attributes of users the current user is following" do
    VCR.use_cassette("github_user_service_get_followings") do
      user = User.create(
        uid: "1234",
        provider: "github",
        username: "dtinianow",
        name: "David Tinianow",
        token: ENV["GITHUB_TOKEN"]
      )
      followings = GithubUser.followings(user)
      following = followings.first

      expect(following.login).to eq "jcasimir"
      expect(following.events_url).to eq "https://api.github.com/users/jcasimir/events{/privacy}"
    end
  end
end
