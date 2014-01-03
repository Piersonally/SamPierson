require 'spec_helper'

describe Heroku::Backup do
  let(:heroku) { Heroku.new "fakeapp" }
  let(:pgbackups_line) { "b002  2014/01/02 20:18.59  Finished @ 2014/01/02 20:19.03  45.2KB  HEROKU_POSTGRESQL_TEAL_URL (DATABASE_URL)" }

  describe ".new" do
    subject { Heroku::Backup.new pgbackups_line, heroku }

    it "should correctly process a line from pgbackups" do
      expect(subject).to be_a Heroku::Backup
      expect(subject.id).to eq 'b002'
      expect(subject.status).to eq 'Finished'
      expect(subject.backup_at).to eq Time.at 1388693880
      expect(subject.status_at).to eq Time.at 1388693940
      expect(subject.size).to eq "45.2KB"
      expect(subject.db).to eq "HEROKU_POSTGRESQL_TEAL_URL"
    end
  end

  describe "instance methods" do
    let(:backup) { Heroku::Backup.new pgbackups_line, heroku }
    let(:backup_url) { "https://s3.amazonaws.com/hkpgbackups/app18176416@heroku.com/b002.dump?AWSAccessKeyId=AKIAJSFW5453GUTHFHKA&Expires=1388698609&Signature=3l4dc23MB7KOpD77vBn241M4aaM%3D" }

    describe "#uri" do
      subject { backup.uri }

      it "should execute a command to get a URI for the backup" do
        heroku.should_receive(:run)
              .with("pgbackups:url b002")
              .and_return(%("#{backup_url}"))
        expect(subject).to be_a URI
        expect(subject.host).to eq "s3.amazonaws.com"
        expect(subject.path).to eq "/hkpgbackups/app18176416@heroku.com/b002.dump"
      end
    end

    describe "#get" do
      subject { backup.get }
      before { backup.stub(:uri) { URI.parse backup_url } }

      it "should execute a curl command to download the backup to the tmp folder" do
        backup.should_receive(:execute)
              .with("curl -o tmp/b002.dump '#{backup_url}'")
              .and_return("")
        subject.should eq "tmp/b002.dump"
      end
    end

    describe "#destroy" do
      subject { backup.destroy }

      it "should send a command to heroku to destory the backup" do
        heroku.should_receive(:run).with("pgbackups:destroy b002")
        subject
      end
    end
  end
end
