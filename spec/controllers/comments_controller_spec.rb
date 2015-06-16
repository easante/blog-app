require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
      @john = User.create(email: "john@example.com", password: "password")
    end

    context "signed in user" do
      it "renders the edit template" do
        login_user @john

        article = Article.create(title: "First Article",
                                  body: "Lorem Ipsum", user: @john)

        post :create, comment: {body: "Awesome post"}, article_id: article.id
        expect(flash[:success]).to eq("Comment has been created")
      end
    end

    context "non-signed in user" do
      it "renders the edit template" do
        login_user nil

        article = Article.create(title: "First Article",
                                  body: "Lorem Ipsum", user: @john)

        post :create, comment: {body: "Awesome post"}, article_id: article.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
