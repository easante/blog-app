require "rails_helper"

RSpec.feature "Listing Articles" do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    # login_as(@john)

    @article1 = Article.create(title: "The first article",
                body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
    @article2 = Article.create(title: "The second article",
                body: "Pellentesque ac ligula in tellus feugiat iaculis.")
  end

  scenario "Non-signed in users do not see 'New Article' link" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end

  scenario "Signed in users see all articles and link" do
    login_as(@john)

    visit "/"
    expect(page).to have_link("New Article")
  end

end
