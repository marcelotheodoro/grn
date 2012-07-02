# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'rails/generators/migration'

require 'mdd/generators'

module Grn
  module Generators
    class P1Generator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      
      attr_accessor :resource_type_name, :resource_type_attributes, :resource_name, :resource_attributes, :resource, :resource_type

      class_option :type_name, :desc => 'Resource type name', :type => :string
      class_option :type_attributes, :desc => 'Resource type attributes', :type => :string

      class_option :resource_name, :desc => 'Resource name', :type => :string
      class_option :resource_attributes, :desc => 'Resource attributes', :type => :string

      def initialize(*args, &block)

        super
        
        # resource type
        @resource_type_name = options.type_name || ask("Choose the resource type name.\nExample: Category, ProductCategory, etc.\nResource type name:")
        @resource_type = Mdd::Generators::Model.new( @resource_type_name )
        print_usage unless @resource_type.valid?
        
        #resource type attributes
        @resource_type_attributes = options.type_attributes || ask("Choose the resource type attributes.\nSyntax: similar to MDD gem. Description is already included.\nResource type attributes:")
        @resource_type_attributes.split(' ').each do |attribute|
          @resource_type.add_attribute Mdd::Generators::ModelAttribute.new( attribute )
        end

        # resource 
        @resource_name = options.resource_name || ask("Choose the resource name.\nExample: Product, Movie, Equipment, etc.\nResource name:")
        @resource = Mdd::Generators::Model.new( @resource_name )
        print_usage unless @resource.valid?
        
        # resource attributes
        @resource_attributes = options.resource_attributes || ask("Choose the resource attributes.\nSyntax: similar to MDD gem. Description is already included.\nResource attributes:")
        @resource_attributes.split(' ').each do |attribute|
          @resource.add_attribute Mdd::Generators::ModelAttribute.new( attribute )
        end

      end
      
      def log
        
        template 'test.rb', 'p1_generator.txt'
        
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