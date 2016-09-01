class GithubUserService < InitializeGithubService
  include Parser

  def get_github_user
    response = @connection.get "user"
    parse(response)
  end

  def get_followings
    response = @connection.get "users/#{@user.username}/following"
    parse(response)
  end
end
