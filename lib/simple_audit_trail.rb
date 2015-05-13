require 'simple_audit_trail/engine'

module SimpleAuditTrail
  module Auditor
    extend ActiveSupport::Concern

    module ClassMethods
      def audit(fields, options = {})
        cattr_accessor :audited_fields
        self.audited_fields = fields.map(&:to_s)

        cattr_accessor :audit_options
        self.audit_options = { :require_audited_user_id => true }.merge(options)


        attr_accessor :audited_user_id

        has_many :simple_audits,
                 :as => :simple_audit_trailable,
                 :class_name => "SimpleAuditTrail::Audit",
                 :autosave => true

        before_update :save_audits
        define_method :save_audits do
          if self.audited_user_id.nil? && self.audit_options[:require_audited_user_id]
            raise "audited setter method called without setting audited_user_id"
          end
          if (self.changed & self.audited_fields).any?
            to = Hash[self.audited_fields.map{|k| [k,self[k]]}]
            from = to.clone.merge! Hash[
              self.changes.slice(*self.audited_fields).map{|k,v| [k,v[0]]}
            ]

            self.simple_audits.create(
              :from => from.to_json,
              :to => to.to_json,
              :who_id => self.audited_user_id)
          end
        end
      end
    end
  end
  ActiveRecord::Base.send :include, SimpleAuditTrail::Auditor
end
