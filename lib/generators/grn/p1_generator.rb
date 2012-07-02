# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'rails/generators/migration'

module Grn
  module Generators
    class P1Generator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      
      attr_accessor :resource_type_name, :resource_type_attributes, :resource_name, :resource_attributes

      class_option :type_name, :desc => 'The name of the resource type', :type => :string
      class_option :type_attributes, :desc => 'The name of the resource type', :type => :string

      class_option :resource_name, :desc => 'The name of the resource type', :type => :string
      class_option :resource_attributes, :desc => 'The name of the resource type', :type => :string

      def initialize(*args, &block)

        super
        
        @resource_type_name = options.type_name || ask("Name of the resource type?\nExample: Category, ProductCategory...\n")
        @resource_type_attributes = options.type_attributes || ask("What's the name of the resource type?")

      end
      
      # Implement the required interface for Rails::Generators::Migration.
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S").to_s
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

    end # class
  end # generators
end # grn