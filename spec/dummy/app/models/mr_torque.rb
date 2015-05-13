class MrTorque < ActiveRecord::Base
  attr_accessible :todays_quote
  audit [:todays_quote], :require_audited_user_id => false
end
