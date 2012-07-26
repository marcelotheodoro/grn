# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "<%= @tipo_recurso_nome %>" do |e|
  
  e.resource  = true      # should it be stored like a resource?
  e.ajax      = true      # scaffold with ajax?
  e.scaffold_name = 'a/<%= @tipo_recurso_nome.underscore %>' # mdwa sandbox specific code?
  e.model_name = 'a/<%= @tipo_recurso_nome.underscore %>' # use specific model name? or different namespace?

  ##
  ## Define entity attributes
  ##
  e.attribute do |attr|
    attr.name = 'name'
    attr.type = 'string'
  end
  
  ##
  ## Define entity associations
  ##
  e.association do |a|
    a.type = 'one_to_many'
    a.destination = '<%= @recurso_nome %>' # entity name
  end

  ##
  ## Entity specifications. 
  ## Define restrictions and rules so this entity will work properly.
  ##
  e.specify "nome não pode ser nulo"
  
end