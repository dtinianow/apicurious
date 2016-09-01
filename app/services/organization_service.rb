class OrganizationService < InitializeGithubService
  include Parser

  def get_organizations
    response = @connection.get "/users/#{@user.username}/orgs"
    parse(response)
  end
end
