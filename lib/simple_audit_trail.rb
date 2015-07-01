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
          changed_audited_fields = audited_fields.select do |f|
            send "#{f}_changed?"
          end

          if changed_audited_fields.present?
            if audited_user_id.nil? && audit_options[:require_audited_user_id]
              raise "audited setter method called without setting audited_user_id"
            end

            to = Hash[changed_audited_fields.map { |f| [f, send(f)] }]
            from = Hash[changed_audited_fields.map { |f| [f, send("#{f}_was")] }]
            unchanged = Hash[
              (audited_fields - changed_audited_fields).map do |f|
                [f, send(f)]
              end
            ]

            simple_audits.create(
              :from => from.to_json,
              :to => to.to_json,
              :unchanged => unchanged.to_json,
              :who_id => audited_user_id
            )
          end
        end
      end
    end
  end
  ActiveRecord::Base.send :include, SimpleAuditTrail::Auditor
end
