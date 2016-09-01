class UsersController < ApplicationController

  def show
    @user = GithubUser.find(current_user)
    @starred_repos = Repo.count(current_user)
    @repos = Repo.user_repos(current_user)
    @user_activity = Activity.user_activity(current_user)
    @followings_activity = Activity.followings_activity(current_user)
    @organizations = Organization.organizations(current_user)
  end
end
