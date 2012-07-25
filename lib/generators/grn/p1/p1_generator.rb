# -*- encoding : utf-8 -*-
require 'rails/generators'

require 'mdd/dsl'

module Grn
  module Generators
    class P1Generator < Rails::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)
      
      attr_accessor :recurso_nome, :tipo_recurso_nome      
      
      class_option :nomes_padroes, :type => :boolean, :default => false
      
      def gerar_arquivos
        @recurso_nome = ask('Nome do recurso:') || 'Recurso'
        template 'recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{@recurso_nome}.rb"
        
        @tipo_recurso_nome = ask('Nome do tipo do recurso:') || 'TipoRecurso'
        template 'recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{@recurso_nome}.rb"
      end 

    end # class
  end # generators
end # grn