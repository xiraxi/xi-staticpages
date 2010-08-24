class StaticPagesController < ApplicationController

  only_admins :new, :create, :edit, :update, :destroy, :index

  def new
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.new(params[:static_page])
    if @static_page.save
      flash[:notice] = t("static_pages.create.success")
      redirect_to static_page_path(@static_page)
    else
      flash[:notice] = t("static_pages.create.error")
      render :action => "new"
    end
  end

  def edit
    @static_page = StaticPage.find(params[:id])
  end

  def update
    @static_page = StaticPage.find(params[:id])
    if @static_page.update_attributes(params[:static_page])
      flash[:notice] = t("static_pages.update.success")
      redirect_to static_page_path(@static_page)
    else
      flash[:notice] = t("static_pages.update.error")
      render :action => "edit"
    end
  end

  def show
    @static_page = StaticPage.find(params[:id])
  end

  def destroy
    # TODO
  end

  def index
    @static_pages = StaticPage.all
  end
end
