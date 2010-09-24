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
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def destroy
    static_page = StaticPage.find(params[:id])
    if static_page.destroy
      flash[:notice] = t("static_pages.destroy.success")
      redirect_to static_pages_path
    else
      flash[:error] = t("static_pages.destroy.error")
      redirect_to static_page
    end
  end

  def index
    @static_pages = StaticPage.without_parent.order("work_as_directory, position").all
  end
end
