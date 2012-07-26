# -*- encoding : utf-8 -*-
require 'rails/generators'

require 'mdwa/dsl'

module Grn
  module Generators
    class RoteiroGenerator < Rails::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)
      
      attr_accessor :recurso_nome, :tipo_recurso_nome # padrão 1
      attr_accessor :quantificacao_recurso # padrão 2
            
      def initialize(*args, &block)
        super
        
        # padrão 1
        @recurso_nome = ask('Nome do recurso: ') || 'Recurso'
        @tipo_recurso_nome = ask('Nome do tipo do recurso: ') || 'TipoRecurso'
        
        # padrão 2
        @quantificacao_recurso = ask('Tipo de quantificação de recurso (simples, instanciavel, mensuravel, lotes): ').gsub('á','a').underscore.to_sym
        @quantificacao_recurso = :simples unless [:simples, :instanciavel, :mensuravel, :lotes].include?(@quantificacao_recurso)
        if recurso_instanciavel?
          @nome_quantificacao_recurso = (ask('Nome da instância do recurso: ') || "Instancia#{@recurso_nome}") 
        end
        if recurso_lotes?
          @nome_quantificacao_recurso = ask('Lote do recurso: ') || "Lote#{@recurso_nome}"
        end
        if recurso_lotes? || recurso_mensuravel?
          @nome_unidade_medida = (ask('Nome da unidade de medida: ') || 'UnidadeMedida')
        end
        
      end
      
      def padrao1
        template 'identificar_recurso/recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@recurso_nome).file_name}.rb"
        template 'identificar_recurso/tipo_recurso.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@tipo_recurso_nome).file_name}.rb"
      end 
      
      def padrao2
        if recurso_instanciavel?
          template 'quantificar_recurso/recurso_instanciavel.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@nome_quantificacao_recurso).file_name}.rb"
        end
        if recurso_lotes?
          template 'quantificar_recurso/recurso_instanciavel.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@nome_quantificacao_recurso).file_name}.rb"
          template 'quantificar_recurso/unidade_medida.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@nome_unidade_medida).file_name}.rb"
        end
        if recurso_mensuravel?
          template 'quantificar_recurso/unidade_medida.rb', "#{MDWA::DSL::STRUCTURAL_PATH}#{MDWA::DSL::Entity.new(@nome_unidade_medida).file_name}.rb"
        end
      end
      
      private 
        
        def recurso_simples?
          @quantificacao_recurso == :simples
        end
        
        def recurso_instanciavel?
          @quantificacao_recurso == :instanciavel
        end
        
        def recurso_mensuravel?
          @quantificacao_recurso == :mensuravel
        end
        
        def recurso_lotes?
          @quantificacao_recurso == :lotes
        end
          

    end # class
  end # generators
end # grn