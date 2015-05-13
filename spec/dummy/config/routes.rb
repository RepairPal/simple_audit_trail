Rails.application.routes.draw do

  mount SimpleAuditTrail::Engine => "/simple_audit_trail"
end
