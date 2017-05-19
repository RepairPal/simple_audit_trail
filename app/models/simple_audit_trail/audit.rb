module SimpleAuditTrail
  class Audit < ActiveRecord::Base
    belongs_to :simple_audit_trailable, :polymorphic => true
    def self.table_name
      "simple_audit_trail_audits"
    end

    before_save :set_location_fields

    def set_location_fields
      self.trace ||= caller.select do |entry|
        !(entry =~ /#{__FILE__}/) && (entry[0] != "/" || entry =~ /#{Rails.root}/)
      end.join("\n")
      match = trace.match(/(\w+)_controller.rb.*`(\w+)'/)
      c, a = match && match[1..-1]
      self.controller ||= c
      self.action ||= a
    end
  end
end
