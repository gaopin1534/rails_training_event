require "rails_helper"
RSpec.describe '/auth', type: :feature do
  subject { page }

  describe '/event/tweet' do

    let(:event){ create :event }
    context 'tweet with github login' do
      let!(:user) { create :user, provider: 'github' }
      before do
        login! user
        visit event_path id: event.id
      end
      it { should_not have_css '#tweet_form' }
    end
    context 'tweet with facebook login' do
      let!(:user) { create :user, provider: 'facebook' }
      before do
        login! user
        visit event_path id: event.id
      end
      it { should_not have_css '#tweet_form' }
    end

    context 'has tweet with facebook login' do
      let!(:user) { create :user, provider: 'twitter' }
      before do
        login! user
        visit event_path id: event.id
      end
      it { should have_css '#tweet_form' }
    end

    context 'tweet with twitter login' do
      let!(:user) { create :user, provider: 'twitter' }
      before do
        login! user
        visit event_path(event.id)
        fill_in 'tweet', with: "test content"
        @client = double(Twitter::REST::Client, :update => "hogehoge")
        Twitter::REST::Client.stub(:new).and_return(@client)
        click_button I18n.t(:tweet)
      end
      it { should have_content I18n.t(:tweet_notice) }
      it { current_path.should eq event_path(event.id) }
    end
  end
end
