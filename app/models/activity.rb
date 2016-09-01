class Activity < OpenStruct

  def self.service(user)
    @@service ||= ActivityService.new(user)
  end

  def self.user_activity(user)
    activities_hash = service(user).get_user_activity
    activities = activities_hash.map { |activity| Activity.new(activity) }
    self.sort_activities(activities)
  end

  def self.followings_activity(user)
    activities_hash = service(user).get_followings_activity
    activities = activities_hash.map { |activity| Activity.new(activity) }
    self.sort_activities(activities)
  end

  def self.sort_activities(activities)
    commits = activities.select do |activity|
      activity[:type] == "PushEvent" && activity.payload['commits'].first
    end
    commits.sort_by { |data| data[:created_at] }.reverse
  end

  def commit_message
    payload['commits'].first.message
  end
end
