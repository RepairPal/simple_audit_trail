class Tina < ActiveRecord::Base
  attr_accessible :badonkadonks, :ladies, :mushy_snugglebites
  audit [:ladies, :badonkadonks]
end
