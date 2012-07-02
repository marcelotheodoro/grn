module Grn
  
  class Resource < ActiveRecord::Base
    
    # override
    # identify the resource type according to GRN first pattern
    def resource_type
    end
    
  end
  
end