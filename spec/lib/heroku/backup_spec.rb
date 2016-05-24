require 'spec_helper'

describe Heroku::Backup do
  let(:heroku) { Heroku.new "fakeapp" }
  let(:pgbackups_line) { "oa498  2014-01-02 20:18:59 +0000  Completed 2014-01-02 20:19:03 +0000  45.2kB  DATABASE" }

  describe ".new" do
    subject { Heroku::Backup.new pgbackups_line, heroku }

    it "should correctly process a line from pgbackups" do
      expect(subject).to be_a Heroku::Backup
      expect(subject.id).to eq 'oa498'
      expect(subject.status).to eq 'Completed'
      expect(subject.backup_at).to eq Time.at 1388693939
      expect(subject.status_at).to eq Time.at 1388693943
      expect(subject.size).to eq "45.2kB"
      expect(subject.db).to eq "DATABASE"
    end
  end

  describe "instance methods" do
    let(:backup) { Heroku::Backup.new pgbackups_line, heroku }
    let(:backup_url) { "https://s3.amazonaws.com/hkpgbackups/app18176416@heroku.com/oa498.dump?AWSAccessKeyId=AKIAJSFW5453GUTHFHKA&Expires=1388698609&Signature=3l4dc23MB7KOpD77vBn241M4aaM%3D" }

    describe "#uri" do
      subject { backup.uri }

      it "should execute a command to get a URI for the backup" do
        expect(heroku).to receive(:run)
              .with("pg:backups public-url oa498")
              .and_return(%("#{backup_url}"))
        expect(subject).to be_a URI
        expect(subject.host).to eq "s3.amazonaws.com"
        expect(subject.path).to eq "/hkpgbackups/app18176416@heroku.com/oa498.dump"
      end
    end

    describe "#get" do
      subject { backup.get }
      before { allow(backup).to receive(:uri) { URI.parse backup_url } }

      it "should execute a curl command to download the backup to the tmp folder" do
        expect(backup).to receive(:execute)
              .with("curl -o tmp/oa498.dump '#{backup_url}'")
              .and_return("")
        expect(subject).to eq "tmp/oa498.dump"
      end
    end

    describe "#destroy" do
      subject { backup.destroy }

      it "should send a command to heroku to destory the backup" do
        expect(heroku).to receive(:run).with("pg:backups delete oa498")
        subject
      end
    end
  end
end
