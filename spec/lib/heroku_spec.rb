require 'spec_helper'

describe Heroku do
  let(:heroku) { Heroku.new 'fakeapp' }

  describe "#list_backups" do
    subject { heroku.list_backups }

    let(:pgbackups_output) {
      <<-PGBACKUPS_OUTPUT
=== Backups
ID     Backup Time                Status                               Size    Database
-----  -------------------------  -----------------------------------  ------  --------
oa498  2015-05-19 06:49:42 +0000  Completed 2015-05-19 06:51:20 +0000  67.2kB  DATABASE
oa497  2015-05-18 06:29:27 +0000  Completed 2015-05-18 06:59:28 +0000  67.2kB  DATABASE
oa496  2015-05-17 06:21:13 +0000  Completed 2015-05-17 06:37:33 +0000  67.2kB  DATABASE

=== Restores
No restores found. Use `heroku pg:backups restore` to restore a backup

=== Copies
No copies found. Use `heroku pg:copy` to copy a database to another
      PGBACKUPS_OUTPUT
    }

    before do
      allow(heroku).to receive(:`)
            .with('heroku pg:backups --app fakeapp')
            .and_return(pgbackups_output)
    end

    it "should return an array containing backups" do
      expect(subject).to be_a(Array)
      expect(subject.length).to eq 3
      expect(subject.first).to be_a(Heroku::Backup)
      backup_ids = subject.map { |backup| backup.id }
      expect(backup_ids).to eq %w[oa498 oa497 oa496]
    end
  end
end
