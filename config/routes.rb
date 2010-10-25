Rails.application.class.routes.draw do
  resources :static_pages

  match "adhoc/attachments/new" => "static_pages#attach_file", :as => :static_page_attach_file
end
