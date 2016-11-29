class MrTorque < ActiveRecord::Base
  audit [:todays_quote], :require_audited_user_id => false
end
