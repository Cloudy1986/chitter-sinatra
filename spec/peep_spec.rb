require 'peep'

describe Peep do
  
  describe '.all' do
    it 'returns a list of peeps' do
      peeps = Peep.all

      expect(peeps.length).to eq 3
      expect(peeps[0]).to eq "I'm learning to code and practising building a web app"
      expect(peeps[1]).to eq "Ruby is the best!"
      expect(peeps[2]).to eq "I'm loving using Sinatra to build a web app"
    end 
  end

end