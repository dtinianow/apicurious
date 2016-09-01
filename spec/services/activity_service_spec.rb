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

  context "#get_user_activity" do
    it "returns data about recent activity of the current user" do
      VCR.use_cassette("activity_service_get_user_activity") do

        activities = ActivityService.new(@user).get_user_activity
        activity = activities.first

        expect(activities.count).to eq 30
        expect(activity).to respond_to :type
        expect(activity).to respond_to :created_at
        expect(activity).to respond_to :actor
        expect(activity).to respond_to :repo
        expect(activity).to respond_to :payload
        expect(activity[:type].class).to eq(String)
        expect(activity[:created_at].class).to eq(String)
        expect(activity[:actor].class).to eq(OpenStruct)
        expect(activity[:repo].class).to eq(OpenStruct)
        expect(activity[:payload].class).to eq(OpenStruct)
      end
    end
  end

  context "#get_followings_activity" do
    it "returns data about activity of users the current user is following" do
      VCR.use_cassette("activity_service_get_followings_activity") do

        activities = ActivityService.new(@user).get_followings_activity
        activity = activities.first

        expect(activities.count).to eq 180
        expect(activity).to respond_to :type
        expect(activity).to respond_to :created_at
        expect(activity).to respond_to :actor
        expect(activity).to respond_to :repo
        expect(activity).to respond_to :payload
        expect(activity[:type].class).to eq(String)
        expect(activity[:created_at].class).to eq(String)
        expect(activity[:actor].class).to eq(OpenStruct)
        expect(activity[:repo].class).to eq(OpenStruct)
        expect(activity[:payload].class).to eq(OpenStruct)
      end
    end
  end
end
