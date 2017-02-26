require 'rails_helper'

RSpec.describe Team::StoriesController, type: :controller do

  context 'when not logged in' do

    it { expect(get(:index)).to redirect_to(root_path) }

  end

  context 'when logged in' do

    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let!(:team_membership) { create(:team_membership, user: user, team: team) }

    before { session[:user_id] = user.id }

    describe 'GET #index' do

      before { get :index, team_id: team.id }

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(:index) }

    end

  end

end
