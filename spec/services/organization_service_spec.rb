require 'rails_helper'

describe OrganizationService do

  before(:each) do
    @user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
  end

  context "#get_organizations" do
    it "returns data about organizations the current user belongs to" do
      VCR.use_cassette("organization_service_get_organizations") do

        organizations = OrganizationService.new(@user).get_organizations
        organization = organizations.first

        expect(organizations.count).to eq 1
        expect(organization).to respond_to :login
        expect(organization).to respond_to :avatar_url
        expect(organization[:login].class).to eq(String)
        expect(organization[:avatar_url].class).to eq(String)
      end
    end
  end
end
