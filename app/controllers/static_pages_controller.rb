class StaticPagesController < ApplicationController

  only_admins :new, :create, :edit, :update, :destroy, :index, :attach_file

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

  def attach_file
    if request.post?
      file = params[:file]
      if file.original_filename =~ /\.(jpeg|jpg|gif|png)$/i

        img_data = file.read
        if img_data.size <= Rails.application.config.static_pages.attachment_size_limit
          img_data_digest = Digest::MD5.new(img_data).hexdigest

          dest_filename = Rails.root.join("public", Rails.application.config.static_pages.attachment_path, img_data_digest + File.extname(file.original_filename))

          dest_dir = dest_filename.dirname
          dest_dir.mkdir if not dest_dir.exist?

          dest_filename.open("w") {|f| f.binmode; f.write img_data }

          #@alt_text = params[:alt_text]
          @public_filename =  "/" + dest_filename.to_s.split("/")[-2..-1].join("/")
          render :action => "attach_file_reply"
          return

        else # size validation
          @attachment_error = :too_big
        end

      else # suffix validation
        @attachment_error = :invalid_suffix
      end

    end

    render :layout => false
  end
end
