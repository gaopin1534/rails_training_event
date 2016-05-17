require "rails_helper"

RSpec.describe '/auth', type: :feature do
  subject { page }

  describe '/event/tweet' do

    let(:event){ create :event }
    context 'tweet with github login' do
      let!(:user) { create :user, provider: 'github' }
      before do
        visit event_path id: event.id
        it { should_not have_css '#tweet_form' }
      end
    end
    context 'tweet with facebook login' do
      let!(:user) { create :user, provider: 'facebook' }
      before do
        visit event_path id: event.id
        it { should_not have_css '#tweet_form' }
      end
    end
    context 'tweet with twitter login' do
      let!(:user) { create :user, provider: 'twitter' }
      before do
        visit event_path id: event.id
        it { should have_css '#tweet_form' }
        fill_in 'tweet', with: "test content"
        click_button 'tweet!'
      end

    end
  end
end
