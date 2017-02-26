# frozen_string_literal: true
class Team::BaseController < ApplicationController
  before_action :authenticate_user!

  def current_team
    @current_team ||= current_user.teams.find(params[:team_id])
  end
end
