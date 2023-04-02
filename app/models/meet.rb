class Meet < ApplicationRecord
    has_many :agendas , :dependent => :destroy 
    accepts_nested_attributes_for :agendas
end
