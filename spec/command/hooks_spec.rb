require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Hooks do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ hooks }).should.be.instance_of Command::Hooks
      end
    end
  end
end

