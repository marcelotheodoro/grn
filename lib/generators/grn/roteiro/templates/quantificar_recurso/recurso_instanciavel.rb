# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "<%= @nome_quantificacao_recurso %>" do |e|
  
  e.resource  = true      # should it be stored like a resource?
  e.ajax      = true      # scaffold with ajax?
  e.scaffold_name = 'a/<%= @nome_quantificacao_recurso.underscore %>' # mdwa sandbox specific code?
  e.model_name = 'a/<%= @nome_quantificacao_recurso.underscore %>' # use specific model name? or different namespace?

  ##
  ## Define entity attributes
  ##
  e.attribute do |attr|
    attr.name = 'codigo'
    attr.type = 'string'
  end
  
  e.attribute do |attr|
    attr.name = 'situacao'
    attr.type = 'integer'
  end
  
  
  ##
  ## Define entity associations
  ##
  e.association do |a|
    a.type = 'many_to_one'
    a.destination = '<%= @recurso_nome %>'
  end

  ##
  ## Entity specifications. 
  ## Define restrictions and rules so this entity will work properly.
  ##
  e.specify "codigo não pode ser nulo"
  e.specify "produto não pode ser nulo"
  
end