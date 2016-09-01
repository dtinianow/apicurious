class Repo < OpenStruct

  def self.service(user)
    RepoService.new(user)
  end

  def self.user_repos(user)
    repos = service(user).get_user_repos
    repos.map do |repo|
      Repo.new(repo)
    end
  end

  def self.starred_repos(user)
    starred_repos = service(user).get_starred_repos
    starred_repos.map do |starred_repo|
      Repo.new(starred_repo)
    end
  end

  def self.count(user)
    self.starred_repos(user).count
  end
end
