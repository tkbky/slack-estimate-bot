require 'rails_helper'

RSpec.describe Me::DashboardsController, type: :controller do

  context 'when not logged in' do

    it { expect(get(:show)).to redirect_to(root_path) }

  end

  context 'when logged in' do

    let(:user) { create(:user) }

    before { session[:user_id] = user.id }

    describe 'GET #show' do

      before { get :show }

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(:show) }

    end

  end

end
