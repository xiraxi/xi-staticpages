class StaticPagesController < ApplicationController

  only_admins :index, :new, :create, :edit, :update, :destroy

  def index
  end

  def new
    @static_page = StaticPage.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
