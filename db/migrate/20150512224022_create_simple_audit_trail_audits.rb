class CreateSimpleAuditTrailAudits < ActiveRecord::Migration
  def change
    create_table :simple_audit_trail_audits do |t|
      t.references :simple_audit_trailable, :polymorphic => true

      t.integer :who_id
      t.text :from
      t.text :to

      t.timestamps
    end
  end
end
