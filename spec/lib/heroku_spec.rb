require 'spec_helper'

describe Heroku do
  let(:heroku) { Heroku.new 'fakeapp' }

  describe "#list_backups" do
    subject { heroku.list_backups }

    let(:pgbackups_output) {
      <<-PGBACKUPS_OUTPUT
ID    Backup Time          Status                          Size    Database
----  -------------------  ------------------------------  ------  -----------------------------------------
b002  2014/01/02 20:18.59  Finished @ 2014/01/02 20:19.03  45.2KB  HEROKU_POSTGRESQL_TEAL_URL (DATABASE_URL)
      PGBACKUPS_OUTPUT
    }

    before do
      heroku.stub(:execute_and_capture_output)
            .with('heroku pgbackups --app fakeapp')
            .and_return { pgbackups_output }
    end

    it "should return an array containing a single backup" do
      expect(subject).to be_a(Array)
      expect(subject.length).to eq 1
      expect(subject.first).to be_a(Heroku::Backup)
      backup = subject.first
      expect(backup.id).to eq 'b002'
    end
  end
end
