require "test_helper"

class UserLogsInWithGithubTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = Apicurious::Application
    stub_omniauth
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login with Github"
    assert_equal "/", current_path
    assert page.has_content?("David Tinianow")
    assert page.has_link?("Logout")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github',
    uid: '1234',
    info: {
      nickname: "dtinianow",
      email: nil,
      name: "David Tinianow",
      image: nil,
      urls: { "Github": nil }
    },
    credentials: {
      token: "pizza"
    },
    extra: {
      raw_info: {
        login: "dtinianow"
      }
    }
  })
end
