require 'rails_helper'

describe RepoService do

  before(:each) do
    @user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
  end

  context "#get_starred_repos" do
    it "returns data about repos the current user has starred" do
      VCR.use_cassette("repo_service_get_starred_repos") do

        starred_repos = RepoService.new(@user).get_starred_repos
        starred_repo = starred_repos.first

        expect(starred_repos.count).to eq 2
        expect(starred_repo).to respond_to :full_name
        expect(starred_repo[:full_name].class).to eq(String)
      end
    end
  end

  context "#get_user_repos" do
    it "returns data about repos belonging to the current user" do
      VCR.use_cassette("repo_service_get_user_repos") do

        repos = RepoService.new(@user).get_user_repos
        repo = repos.first

        expect(repos.count).to eq 27
        expect(repo).to respond_to :name
        expect(repo).to respond_to :full_name
        expect(repo[:name].class).to eq(String)
        expect(repo[:full_name].class).to eq(String)
      end
    end
  end
end
