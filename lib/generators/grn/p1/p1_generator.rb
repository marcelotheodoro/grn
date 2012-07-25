# -*- encoding : utf-8 -*-
require 'rails/generators'

require 'mdwa/dsl'

module Grn
  module Generators
    class P1Generator < Rails::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)
      
      attr_accessor :recurso_nome, :tipo_recurso_nome      
      
      class_option :nomes_padroes, :type => :boolean, :default => false, :desc => 'Usar nomes padrões. "Recurso" para recurso e "TipoRecurso" para tipo de recurso.'
      
      def initialize(*args, &block)
        super
        
        unless options.nomes_padroes
          @recurso_nome = ask('Nome do recurso:')
          @tipo_recurso_nome = ask('Nome do tipo do recurso:')
        end
        @recurso_nome = 'Recurso' if @recurso_nome.blank?
        @tipo_recurso_nome = 'TipoRecurso' if @tipo_recurso_nome.blank?
        
      end
      
      def gerar_arquivos
        template 'recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@recurso_nome).file_name}.rb"
        template 'tipo_recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@tipo_recurso_nome).file_name}.rb"
      end 

    end # class
  end # generators
end # grn