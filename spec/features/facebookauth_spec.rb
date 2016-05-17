require "rails_helper"

RSpec.describe '/auth', type: :feature do
  subject { page }

  describe '/auth/facebook' do
    let(:user1){ build :user }
    context 'success not saved before' do
      before do
        OmniAuth.config.mock_auth[:facebook] =
          OmniAuth::AuthHash.new({
                                   provider: 'facebook',
                                   uid: user1.uid,
                                   info: {
                                     about: user1.description,
                                     name: user1.name,
                                     email: user1.nickname,
                                     image: user1.image,
                                   },
                                   credentials: {
                                     token: user1.token,
                                   }
                                 })
        visit events_path
        click_link 'log-in with Facebook'
        user1.get_data_from_auth_info OmniAuth.config.mock_auth[:facebook]
      end

      it { user1.uid.should eq OmniAuth.config.mock_auth[:facebook][:uid] }
      it { user1.name.should eq OmniAuth.config.mock_auth[:facebook][:info][:name] }
      it { user1.nickname.should eq OmniAuth.config.mock_auth[:facebook][:info][:email] }
      it { user1.token.should eq OmniAuth.config.mock_auth[:facebook][:credentials][:token] }
      it { current_path.should eq events_path }
      it { should have_content "login as #{user1.name}" }
      it { should_not have_content 'login failure' }
    end

    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:facebook] =
          OmniAuth::AuthHash.new({
                                   provider: 'facebook',
                                   uid: user.uid,
                                   info: {
                                     about: user.description,
                                     name: user.name,
                                     email: user.nickname,
                                     image: user.image,
                                   },
                                   credentials: {
                                     token: user.token,
                                   }
                                 })
        visit user_path id: user.id
        click_link 'log-in with Facebook'
        user.get_data_from_auth_info_for_update OmniAuth.config.mock_auth[:facebook]
      end

      it { user.uid.should eq OmniAuth.config.mock_auth[:facebook][:uid] }
      it { user.name.should eq OmniAuth.config.mock_auth[:facebook][:info][:name] }
      it { user.nickname.should eq OmniAuth.config.mock_auth[:facebook][:info][:email] }
      it { user.token.should eq OmniAuth.config.mock_auth[:facebook][:credentials][:token] }
      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit user_path id: user.id
        click_link 'log-in with Facebook'
      end

      it { current_path.should eq events_path }
      it { should have_content 'login failure' }
    end
  end

  describe 'layout' do
    context 'not logged-in' do
      let(:user){ create :user }

      before do
        visit user_path id: user.id
      end

      it { current_path.should eq user_path id: user.id }
      it { should have_content 'log-in with Facebook' }
      it { should_not have_content 'log-out' }
    end

    context 'logged-in' do
      let(:user){ create :user }

      before do
        login! user
        visit user_path id: user.id
      end

      it { current_path.should eq user_path id: user.id }
      it { should have_content 'log-out' }
      it { should_not have_content 'log-in with Facebook' }

      context 'exec log-out' do
        before do
          click_link 'log-out'
        end

        it { current_path.should eq events_path }
        it { should have_content 'log-in with Facebook' }
        it { should_not have_content 'log-out' }
      end
    end
  end
end
