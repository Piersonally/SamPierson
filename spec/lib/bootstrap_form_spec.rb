require 'spec_helper'

describe BootstrapForm, type: :helper do
  describe "#bootstrap_form_for" do
    context "given a model to work with" do
      let(:model) { Account.new }

      subject do
        helper.bootstrap_form_for model do |f|
          f.input :email
        end
      end

      #it "should generate a form" do
      #  expect(subject).to eq(
      #    '<form accept-charset="UTF-8" action="/accounts" class="form-horizontal" id="new_account" method="post">' +
      #      '<div style="margin:0;padding:0;display:inline">'+
      #        '<input name="utf8" type="hidden" value="&#x2713;" />'+
      #      '</div>'+
      #      '<div class="form-group">'+
      #        '<label class="control-label col-sm-3" for="account_email"><abbr title="required">*</abbr> Email</label>'+
      #        '<div class="col-sm-6">'+
      #          '<input class="form-control" id="account_email" name="account[email]" placeholder="Email" required="required" type="email" />'+
      #        '</div>'+
      #      '</div>'+
      #    '</form>'
      #  )
      #end

      describe "the form" do
        it "should have and ID" do
          should have_selector 'form#new_account[action="/accounts"]'
        end

        it "should be a horizontal form" do
          should have_selector 'form#new_account.form-horizontal'
        end

        it "should have role 'form'" do
          should have_selector 'form#new_account[role=form]'
        end
      end


      describe "f.input email" do
        describe "label" do
          it { should have_selector 'form#new_account > .form-group > label.control-label[for=account_email]' }

          it "should make the label 3 columns wide" do
            should have_selector 'label.col-sm-3[for=account_email]'
          end
        end

        it "should give the input an ID, and class form-control" do
          should have_selector 'input#account_email.form-control[name="account[email]"]'
        end

        it "should place the input inside a 6 column div" do
          should have_selector 'form#new_account > .form-group > .col-sm-6 > input#account_email'
        end

        it "should set a placeholder" do
          should have_selector 'input#account_email[placeholder="Email"]'
        end

        it "should make the field required" do
          should have_selector 'input#account_email[required=required]'
        end

        it "should make the field type 'email'" do
          should have_selector 'input#account_email[type=email]'
        end
      end
    end
  end
end
