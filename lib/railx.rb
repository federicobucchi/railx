require "railx/version"
#require File.dirname(__FILE__) + '/../lib/meta_tag_helper'
require File.join(File.dirname(__FILE__), "../", "app", "controllers", "railx_controller.rb")
module Railx
  class Engine < ::Rails::Engine
    ActionController::Base.class_eval do
      include RailxController
    end    
    
  end
end
