class AddTraceControllerActionToSimpleAuditTrails < ActiveRecord::Migration
  def change
    add_column :simple_audit_trail_audits, :trace, :text
    add_column :simple_audit_trail_audits, :controller, :text
    add_column :simple_audit_trail_audits, :action, :text
  end
end
