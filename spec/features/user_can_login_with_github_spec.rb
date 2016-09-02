require 'rails_helper'

RSpec.feature "Visitor can login with github" do
  scenario "they login and see their account data" do

    stub_omniauth
    user = User.create(
      uid: "1234",
      provider: "github",
      username: "dtinianow",
      name: "David Tinianow",
      token: ENV["GITHUB_TOKEN"]
    )
    visit root_path
    click_on "Login"
    visit user_path(user)

    within(".navbar") do
      expect(page).to have_content("Logout")
    end

    within(".username") do
      expect(page).to have_content("David")
    end

    within(".user-full-name") do
      expect(page).to have_content("dtinianow")
    end

    within(".github-categories") do
      expect(page).to have_content("My Repositories")
      expect(page).to have_content("My Organizations")
      expect(page).to have_content("Recent Activity of People I Follow")
      expect(page).to have_content("My Recent Activity")
    end
  end
end
