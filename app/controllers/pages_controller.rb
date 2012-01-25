
class PagesController < ApplicationController
  content_holder_resources 
  enable_bulk_actions :destroy
end
