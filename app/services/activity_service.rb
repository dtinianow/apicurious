class ActivityService < InitializeGithubService
  include Parser

  def get_user_activity
    response = @connection.get "users/#{@user.username}/events"
    parse(response)
  end

  def get_followings_activity
    followings = GithubUser.followings(@user)
    followings.map do |following|
      response = @connection.get "users/#{following.login}/events"
      parse(response)
    end.flatten
  end
end
