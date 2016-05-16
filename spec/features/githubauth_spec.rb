require "rails_helper"

RSpec.describe '/auth', type: :feature do
  subject { page }

  describe '/auth/github' do
    let(:user){ create :user }

    context 'success' do
      before do
        OmniAuth.config.mock_auth[:github] =
          OmniAuth::AuthHash.new({
                                   provider: 'github',
                                   uid: user.uid,
                                   info: {
                                     name: user.name,
                                     nickname: user.nickname,
                                     image: user.image,
                                   },
                                   credentials: {
                                     token: user.token,
                                   }
                                 })
        visit user_path id: user.id
        click_link 'log-in with Github'
      end

      it { current_path.should eq events_path }
      it { should have_content "login as #{user.name}" }
      it { should_not have_content 'login failure' }
    end

    context 'failure' do
      before do
        OmniAuth.config.mock_auth[:github] = :invalid_credentials
        visit user_path id: user.id
        click_link 'log-in with Github'
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
      it { should have_content 'log-in with Github' }
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
      it { should_not have_content 'log-in with Github' }

      context 'exec log-out' do
        before do
          click_link 'log-out'
        end

        it { current_path.should eq events_path }
        it { should have_content 'log-in with Github' }
        it { should_not have_content 'log-out' }
      end
    end
  end
end
