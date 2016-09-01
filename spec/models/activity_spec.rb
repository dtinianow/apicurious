require 'rails_helper'

describe Activity do

  before(:each) do
    @user = User.create(
    uid: "1234",
    provider: "github",
    username: "dtinianow",
    name: "David Tinianow",
    token: ENV["GITHUB_TOKEN"]
    )
  end

  it "returns a list of recent activities belonging to the current user" do
    VCR.use_cassette("activity_service_get_user_activity") do

      activities = Activity.user_activity(@user)
      activity = activities.first

      expect(activities.count).to eq 11
      expect(activity).to respond_to :type
      expect(activity).to respond_to :created_at
      expect(activity).to respond_to :actor
      expect(activity).to respond_to :repo
      expect(activity).to respond_to :payload
      expect(activity.type).to eq "PushEvent"
      expect(activity.created_at).to eq "2016-09-01T20:01:44Z"
      expect(activity.actor.login).to eq "dtinianow"
      expect(activity.repo.name).to eq "dtinianow/apicurious"
      expect(activity.payload['commits'].first.message).to eq "Organization service and model spec"
    end
  end

  # it "returns a list of recent activities belonging to the current user" do
  #   VCR.use_cassette("activity_service_get_followings_activity") do
  #
  #     activities = Activity.user_activity(@user)
  #     activity = activities.first
  #
  #     expect(activities.count).to eq 10
  #     expect(activity).to respond_to :type
  #     expect(activity).to respond_to :created_at
  #     expect(activity).to respond_to :actor
  #     expect(activity).to respond_to :repo
  #     expect(activity).to respond_to :payload
  #     expect(activity.type).to eq "PushEvent"
  #     expect(activity.created_at).to eq "2016-09-01T18:45:44Z"
  #     expect(activity.actor.login).to eq "dtinianow"
  #     expect(activity.repo.name).to eq "dtinianow/apicurious"
  #     expect(activity.payload['commits'].first.message).to eq "Add repo name to user show page"
  #   end
  end
