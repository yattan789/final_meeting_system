class Mom < ApplicationRecord
  
    has_many :actions , dependent: :destroy , inverse_of: :mom
    accepts_nested_attributes_for :actions,  allow_destroy: true, reject_if: :all_blank
end
