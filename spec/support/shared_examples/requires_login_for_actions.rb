shared_examples_for "requires login for actions" do |actions|
  actions.each do |action|
    verb, method, args = action
    subject { send verb, method, args }

    context "while logged out" do
      before { session.delete :account_id }

      describe "#{verb.upcase} #{method}" do
        it "should redirect to the login page" do
          expect(subject).to redirect_to login_path
        end
        it { subject; expect(flash[:alert]).to be_present }
      end
    end
  end
end
