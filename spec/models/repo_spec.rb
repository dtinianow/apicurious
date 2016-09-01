require 'rails_helper'

describe GithubUser do

  before(:each) do
    @user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
  end

  it "returns a list of repos belonging to the current user" do
    VCR.use_cassette("repo_service_get_user_repos") do

      repos = Repo.user_repos(@user)
      repo = repos.first

      expect(repos.count).to eq 27
      expect(repo.name).to eq "headcount"
      expect(repo.full_name).to eq "Automatic365/headcount"
    end
  end

  it "returns a list of repos the current user has starred" do
    VCR.use_cassette("repo_service_get_starred_repos") do

      repos = Repo.starred_repos(@user)
      repo = repos.first

      expect(repos.count).to eq 2
      expect(repo.name).to eq "headcount"
      expect(repo.full_name).to eq "Automatic365/headcount"
    end
  end

  it "returns the count of repos the current user has starred" do
    VCR.use_cassette("repo_service_get_starred_repos") do

      repos = Repo.count(@user)

      expect(repos).to eq 2
    end
  end
end
