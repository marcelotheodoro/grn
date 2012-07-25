# -*- encoding : utf-8 -*-
require 'rails/generators'

require 'mdd/dsl'

module Grn
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)
      
      def inflections
        template 'inflections.rb', 'config/initializers/grn_inflections.rb'
      end

    end # class
  end # generators
end # grn