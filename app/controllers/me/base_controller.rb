# frozen_string_literal: true
class Me::BaseController < ApplicationController
  before_action :authenticate_user!
end
