class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    relationship = current_user.followers.new( followed_id: user.id )
    relationship.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = current_user.followers.find_by( followed_id: user.id )
    relationship.destroy
    redirect_to request.referer
  end
end