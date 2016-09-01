class InitializeGithubService

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.github.com/")
    @connection.headers["Authorization"] = "token #{user.token}"
  end
end
