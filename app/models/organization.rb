class Organization < OpenStruct

  def self.service(user)
    @@service ||= OrganizationService.new(user)
  end

  def self.organizations(user)
    orgs = service(user).get_organizations
    orgs.map do |org|
      Organization.new(org)
    end
  end
end
