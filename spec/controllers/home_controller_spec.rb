require 'spec_helper'

describe HomeController do

  describe "GET about" do
    subject { get :about }
    it { expect(subject).to render_template "about" }
  end
end
