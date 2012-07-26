# -*- encoding : utf-8 -*-
require 'mdwa/dsl'
MDWA::DSL.entities.register "<%= @recurso_nome %>" do |e|
  
  e.resource  = true      # should it be stored like a resource?
  e.ajax      = true      # scaffold with ajax?
  e.scaffold_name = 'a/<%= @recurso_nome.underscore %>' # mdwa sandbox specific code?
  e.model_name = 'a/<%= @recurso_nome.underscore %>' # use specific model name? or different namespace?

  ##
  ## Define entity attributes
  ##
  e.attribute do |attr|
    attr.name = 'descricao'
    attr.type = 'string'
  end
  
  e.attribute do |attr|
    attr.name = 'preco'
    attr.type = 'decimal'
  end
  
  e.attribute do |attr|
    attr.name = 'situacao'
    attr.type = 'string'
  end
  
  ##
  ## Define entity associations
  ##
  e.association do |a|
    a.type = 'many_to_one'
    a.destination = '<%= @tipo_recurso_nome %>'
  end
  
  <%- if recurso_instanciavel? -%>
  e.association do |a|
    a.type = 'one_to_many'
    a.destination = '<%= @nome_quantificacao_recurso %>'
  end
  <%- end -%>

  ##
  ## Entity specifications. 
  ## Define restrictions and rules so this entity will work properly.
  ##
  e.specify "campos devem ser validos" do |s|
     s.such_as "nome não pode ser nulo"
     s.such_as "preço não pode ser nulo"
     s.such_as "categoria não pode ser nula"
   end
   e.specify "valor deve ser maior que zero"
  
  
end