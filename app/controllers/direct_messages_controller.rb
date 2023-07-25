class DirectMessagesController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  before_action :ensure_follow_eathother

  def index
  end

  def show
    @user = User.find(params[:user_id])
    @direct_message = DirectMessage.new
    @direct_messages = DirectMessage.where({ sender_user_id: current_user.id, receiver_user_id: params[:user_id] }).or(DirectMessage.where({ sender_user_id: params[:user_id], receiver_user_id: current_user.id })).order(:id).limit(10)
  end

  def create
    @direct_message = DirectMessage.new(dm_params)
    @direct_message.sender_user_id = current_user.id
    @direct_message.receiver_user_id = params[:user_id]
    @direct_message.save!
    redirect_to request.referrer
  end

  def destroy
  end

  private
    def dm_params
      params.require(:direct_message).permit(:message)
    end

    def ensure_follow_eathother
      unless Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id]) && Relationship.find_by(follower_id: params[:user_id], followed_id: current_user.id)
        redirect_to user_path(params[:user_id])
      end
    end

    def ensure_correct_user
      @direct_message = DirectMessage.find(params[:id])
      unless @direct_message.sender_user_id == current_user.id
        redirect_to request.referer
      end
    end
end
