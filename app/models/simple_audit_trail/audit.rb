module SimpleAuditTrail
  class Audit < ActiveRecord::Base
    attr_accessible :from, :to, :who_id
    belongs_to :simple_audit_trailable, :polymorphic => true
    def self.table_name
      "simple_audit_trail_audits"
    end
  end
end
