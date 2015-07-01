require 'spec_helper'

describe SimpleAuditTrail::Auditor do
  it "adds audit method to ActiveRecord::Base" do
    expect(ActiveRecord::Base).to respond_to(:audit)
  end

  describe "audited model" do
    it "can call #audit" do
        expect {
          Tina.create(:badonkadonks => 2, :ladies => 1)
        }.to_not raise_error
    end

    it "has an audited_fields attribute" do
      t = Tina.create(:badonkadonks => 2, :ladies => 1)

      expect(t.audited_fields).to match_array(["badonkadonks", "ladies"])
    end

    context "#save" do
      before do
        @tina = Tina.create(
          :badonkadonks => 0,
          :ladies => 0
        )
        @tina.reload
      end

      context "when not configured to ignore user" do
        context "when all audited fields have changed" do
          before do
            @tina.badonkadonks = 1
            @tina.ladies = 1

            # requires an audited_user_id
            @tina.audited_user_id = 123
          end

          it "creates a SimpleAuditTrail::Audit record" do
            expect {
              @tina.save
            }.to change(SimpleAuditTrail::Audit, :count).by(1)
          end

          context "the newly created simple_audits record" do
            before do
              @tina.save
            end

            it "is an instance of SimpleAuditTrail::Audit" do
              expect(@tina.simple_audits.last).to be_kind_of SimpleAuditTrail::Audit
            end

            it "has a json hash for what the audited values were" do
              expect(JSON.parse(@tina.simple_audits.last.from)).
                to eq JSON.parse("{\"ladies\":0,\"badonkadonks\":0}")
            end

            it "has a json hash for what the audited values are" do
              expect(JSON.parse(@tina.simple_audits.last.to)).
                to eq JSON.parse("{\"ladies\":1,\"badonkadonks\":1}")
            end

            it "has a who_id for the user who made the change" do
              expect(@tina.simple_audits.last.who_id).to eq 123
            end
          end
        end

        context "when some but not all audited fields have changed then" do
          before do
            @tina.badonkadonks = 1

            # requires an audited_user_id
            @tina.audited_user_id = 123
            @tina.save
          end

          it "has a json hash for what all the audited values were" do
            expect(JSON.parse(@tina.simple_audits.last.from)).
              to eq JSON.parse("{\"ladies\":0,\"badonkadonks\":0}")
          end

          it "has a json hash for what all the audited values are" do
            expect(JSON.parse(@tina.simple_audits.last.to)).
              to eq JSON.parse("{\"ladies\":0,\"badonkadonks\":1}")
          end
        end

        context "when audited fields have not changed" do
          before do
            @tina.mushy_snugglebites = "
              That's Mushy Snugglebites' badonkadonk. She's my main squeeze.
              Lady's got a gut fulla' dynamite and a booty like POOOW!
             "
          end

          it "does not raise an Exception even if no auditor is set" do
            expect(@tina.audited_user_id).to be_blank
            expect { @tina.save }.to_not raise_error
          end

          it "does not create a SimpleAuditTrail::Audit record" do
            expect{
              @tina.save
            }.to_not change(SimpleAuditTrail::Audit, :count)
          end
        end
      end

      context "when configured to ignore user" do
        before do
          @torque = MrTorque.create(
            :todays_quote => "THAT SENTENCE HAD TOO MANY SYLLABLES! APOLOGIZE!"
          )
          @torque.reload
        end

        it "does not raise errors when audit_user_id is empty" do
          @torque.todays_quote =
            "Right now, you're ranked fifty in the badass leaderboards,
             which puts you behind my grandma but ahead of a guy she gummed to
             death. IT TOOK SEVERAL HOURS."
          expect {
            @torque.save
          }.to_not raise_error
        end
        it "does not raise errors when audit_user_id is not empty" do
          @torque.todays_quote =
            "If you're still alive, grab some ammo. If you're not,
             THIS MESSAGE IS IRRELEVANT!"
          @torque.audited_user_id = 345
          expect {
            @torque.save
          }.to_not raise_error
        end

        it "creates a SimpleAuditTrail::Audit record" do
          @torque.todays_quote =
            "If you're still alive, grab some ammo. If you're not,
             THIS MESSAGE IS IRRELEVANT!"
          @torque.audited_user_id = 345
          expect {
            @torque.save
          }.to change(SimpleAuditTrail::Audit, :count).by(1)
        end
      end
    end
  end
end
