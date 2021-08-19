class CategoryObject < ApplicationRecord
  
  belongs_to :category
  belongs_to :objectable, polymorphic: true
end
