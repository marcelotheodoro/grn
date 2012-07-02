# -*- encoding : utf-8 -*-

require 'rails/generators'

require 'mdd/generators/model'
require 'mdd/generators/model_attribute'

module Grn
  module Generators
    class P1Generator < Rails::Generators::Base
      
      attr_accessor :resource_type_name, :resource_type_attributes, :resource_name, :resource_attributes, :resource, :resource_type

      class_option :type_name, :desc => 'Resource type name', :type => :string
      class_option :type_attributes, :desc => 'Resource type attributes', :type => :string

      class_option :resource_name, :desc => 'Resource name', :type => :string
      class_option :resource_attributes, :desc => 'Resource attributes', :type => :string

      def initialize(*args, &block)

        super
        
        # resource type
        @resource_type_name = options.type_name || ask("\nChoose the resource type name.\nExample: Category, ProductCategory, etc.\nResource type name:")
        @resource_type = Mdd::Generators::Model.new( @resource_type_name )
        print_usage unless @resource_type.valid?
        
        #resource type attributes
        @resource_type_attributes = options.type_attributes || ask("\n=============================\nChoose the resource type attributes.\nSyntax: similar to MDD gem. Description is already included.\nResource type attributes:")
        @resource_type_attributes.split(' ').each do |attribute|
          @resource_type.add_attribute Mdd::Generators::ModelAttribute.new( attribute )
        end

        # resource 
        @resource_name = options.resource_name || ask("\n=============================\nChoose the resource name.\nExample: Product, Movie, Equipment, etc.\nResource name:")
        @resource = Mdd::Generators::Model.new( @resource_name )
        print_usage unless @resource.valid?
        
        # resource attributes
        @resource_attributes = options.resource_attributes || ask("\n=============================\nChoose the resource attributes.\nSyntax: similar to MDD gem. Description is already included.\nResource attributes:")
        @resource_attributes.split(' ').each do |attribute|
          @resource.add_attribute Mdd::Generators::ModelAttribute.new( attribute )
        end

      end
      
      
      def mdd_associations
        
        # resouce type
        # generate the scaffold with the attributes
        generate "mdd:scaffold #{@resource_type.raw} description:string #{@resource_type.attributes.map{ |attr| attr.raw }.join(' ')}"
        
        # resouce
        # generate the scaffold with the attributes and belongs_to resource type
        generate "mdd:scaffold #{@resource.raw} description:string #{@resource.attributes.map{ |attr| attr.raw }.join(' ')} #{@resource_type.singular_name}:#{@resource_type.raw}:description:belongs_to"
        
      end 
      
      
      def insert_into_classes
        
        # resource type
        inject_into_class "app/models/#{@resource_type.space}/#{@resource_type.singular_name}.rb", @resource_type.klass.classify.constantize do
          "include Grn::ResourceType"
        end
        
        # resource
        inject_into_class "app/models/#{@resource.space}/#{@resource.singular_name}.rb", @resource.klass.classify.constantize do
          "include Grn::Resource"
        end
        
      end

    end # class
  end # generators
end # grn