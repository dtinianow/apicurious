require 'rails_helper'

describe Organization do

  before(:each) do
    @user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
  end

  it "returns a list of organizations the current user belongs to" do
    VCR.use_cassette("organization_service_get_organizations") do

      organizations = Organization.organizations(@user)
      organization = organizations.first

      expect(organizations.count).to eq 1
      expect(organization.login).to eq "CuriousAPIs"
      expect(organization.avatar_url).to eq "https://avatars.githubusercontent.com/u/21352536?v=3"
    end
  end
end
