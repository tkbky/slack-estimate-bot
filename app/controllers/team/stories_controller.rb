# frozen_string_literal: true
class Team::StoriesController < Team::BaseController
  def index
    @stories = current_team.stories
  end
end
