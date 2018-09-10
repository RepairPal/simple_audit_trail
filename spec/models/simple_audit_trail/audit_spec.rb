require_relative '../../spec_helper'

describe SimpleAuditTrail::Audit do
  before do
    @audit = SimpleAuditTrail::Audit.new(
      from: { badonkadonks: 20 }.to_json,
      to: { badonkadonks: 21 }.to_json,
      who_id: 29
    )
  end

  it 'can be instantiated' do
    expect(@audit).to be_kind_of SimpleAuditTrail::Audit
  end
end
