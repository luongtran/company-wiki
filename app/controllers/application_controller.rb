class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include PublicActivity::StoreController
  include ActionView::Helpers::TextHelper  
  
end
