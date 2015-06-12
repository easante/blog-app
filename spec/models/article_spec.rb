require "rails_helper"

RSpec.describe Article, :type => :model do
  it "requires a title" do
    article = Article.new(body: "Lorem Ipsum")
  end
end
