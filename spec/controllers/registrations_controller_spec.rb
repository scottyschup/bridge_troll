require 'rails_helper'

describe DeviseOverrides::RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @chapter = Chapter.create!(name: 'Neue Chapter')
  end

  describe "#create" do
    describe 'chapter selection' do
      let(:user_params) do
        {
          first_name: 'Beep',
          last_name: 'Boop',
          chapter_ids: [@chapter.id],
          email: 'boop1@example.com',
          password: 'abc123',
          password_confirmation: 'abc123'
        }
      end

      it "allows user to select a chapter" do
        expect {
          post :create, params: {user: user_params}
        }.to change(@chapter.users, :count).by(1)

        # TODO: fixme, currently prints out a big error
        # expect(response).to be_redirect
        expect(User.last.chapters).to eq([@chapter])
      end

      it "does not asplode if user does not select a chapter" do
        expect {
          post :create, params: {user: user_params.merge(chapter_ids: [])}
        }.to change(@chapter.users, :count).by(0)

        # TODO: fixme, currently prints out a big error
        # expect(response).to be_redirect
        expect(User.last.chapters).to be_empty
      end
    end
  end
end
