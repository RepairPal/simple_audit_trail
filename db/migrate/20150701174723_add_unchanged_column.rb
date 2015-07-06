class AddUnchangedColumn < ActiveRecord::Migration
  def change
    add_column :simple_audit_trail_audits, :unchanged, :text
  end
end
