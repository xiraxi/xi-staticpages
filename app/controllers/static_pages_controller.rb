class StaticPagesController < ApplicationController

  only_admins :index, :new, :create, :edit, :update, :destroy

  def index
  end

  def new
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.new(params[:static_page])
    if @static_page.save
      flash[:notice] = t("static_pages.create.success")
      redirect_to statict_pages_path
    else
      flash[:notice] = t("static_pages.create.error")
      render :action => "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
