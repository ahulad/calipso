class HomeController < ApplicationController
  include ApplicationHelper

  def index
    if user_signed_in?
      @tableout=count_summ_oper
    end
  end

end