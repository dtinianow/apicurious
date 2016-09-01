class RepoService < InitializeGithubService
  include Parser

  def get_starred_repos
    response = @connection.get "user/starred"
    parse(response)
  end

  def get_user_repos
    response = @connection.get "user/repos"
    parse(response)
  end
end
