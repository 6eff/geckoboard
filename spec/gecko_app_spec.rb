require_relative "spec_helper"
require_relative "../gecko_app.rb"

Capybara.app = GeckoApp

feature "Managing Tasks" do
  scenario "user should be able to add a task into the database" do
    visit "/"
    fill_in "description", with: "Finish writing this blog post"
    click_on "Submit"
    expect(page).to have_content("Finish writing this blog post")
  end
end

describe GeckoApp do
  it "responds with a welcome message" do
    get '/'

    last_response.body.must_include 'Welcome to the Sinatra Template!'
  end
end
