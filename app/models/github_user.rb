class GithubUser < OpenStruct

  def self.service(user)
    @@service ||= GithubUserService.new(user)
  end

  def self.find(user)
    user_hash = service(user).get_github_user
    GithubUser.new(user_hash)
  end

  def self.followings(user)
    followings_hash = service(user).get_followings
    followings_hash.map { |following| GithubUser.new(following) }
  end
end
