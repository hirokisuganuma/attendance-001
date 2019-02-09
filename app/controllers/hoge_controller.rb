class HogeController < ApplicationController
  def top
    @user = User.find(params[:id])
  end
end
