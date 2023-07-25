class SearchesController < ApplicationController
  def search
    @books = []
    @users = []
    if params[:target] == "user" # User search
      case params[:option]
      when "1" then
        @users = User.where("name = ?", params[:word])
      when "2" then
        @users = User.where("name like ?", "#{params[:word]}%")
      when "3" then
        @users = User.where("name like ?", "%#{params[:word]}")
      when "4" then
        @users = User.where("name like ?", "%#{params[:word]}%")
      end
    elsif params[:target] == "book" # Book search
      case params[:option]
      when "1" then
        @books = Book.where("title = ? or body = ?", params[:word], params[:word])
      when "2" then
        @books = Book.where("title like ? or body like ?", "#{params[:word]}%", "#{params[:word]}%")
      when "3" then
        @books = Book.where("title like ? or body like ?", "%#{params[:word]}", "%#{params[:word]}")
      when "4" then
        @books = Book.where("title like ? or body like ?", "%#{params[:word]}%", "%#{params[:word]}%")
      end
    end
  end
end
