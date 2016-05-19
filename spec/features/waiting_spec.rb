require "rails_helper"
RSpec.describe '/events', type: :feature do
  subject { page }
  describe '/events/:id' do
    let(:event) { create :event, capacity: 1 }
    let!(:user1) { create :user }
    let!(:atendee1){ create :atendee, event_id: event.id, user_id: user1.id }
    let!(:user2) { create :user }
    before do
      visit event_path event
    end

    it { should have_css '#waiting' } #補欠者リスト

    context 'logged-in' do
      before do
        login! user2
        visit event_path event
      end

      describe 'atendee' do
        context 'not attend' do
          it { should have_link('Join Wait List', wait_event_path(event)) }

          context 'click Join Wait List' do
            before do
              click_link('Join Wait List')
            end

            it { current_path.should eq event_path(event) }
            it { find('#waiting').should have_content user2.name }
            it { find('#absence').should_not have_content user2.name }
            it { find('#attendance').should_not have_content user2.name }

            context 'click Cancel Waiting' do
              before do
                click_link('Cancel Waiting')
              end

              it { current_path.should eq event_path(event) }
              it { find('#attendance').should_not have_content user2.name }
              it { find('#waiting').should_not have_content user2.name }
              it { find('#absence').should have_content user2.name }

              context 'click Join Wait List again' do
                before do
                  click_link('Join Wait List')
                end

                it { current_path.should eq event_path(event) }
                it { find('#waiting').should have_content user2.name }
                it { find('#absence').should_not have_content user2.name }
                it { find('#attendance').should_not have_content user2.name }
              end
            end

          end
        end

        context 'already Waiting' do
          let!(:atendee2){ create :atendee, event_id: event.id, user_id: user2.id , status: "waiting"}

          before do
            visit event_path event
          end

          it { should have_link('Cancel Waiting', absent_event_path(event)) }
        end
      end
    end

    context 'other one logged-in' do
      let!(:atendee2){ create :atendee, event_id: event.id, user_id: user2.id , status: "waiting"}
      before do
        login! user1
        visit event_path event
      end
      describe 'atendee' do
        context 'click Cancel Waiting and user2 should be attendance' do
          before do
            click_link('Absent')
          end

          it { current_path.should eq event_path(event) }
          it { find('#attendance').should have_content user2.name }
          it { find('#waiting').should_not have_content user2.name }
          it { find('#absence').should_not have_content user2.name }
        end
      end
    end
  end

end
