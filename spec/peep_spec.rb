# frozen_string_literal: true

require 'peep'

describe Peep do
  describe '.all' do
    it 'returns a list of peeps' do
      connection = PG.connect(dbname: 'chitter_sinatra_test')
      connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Test peep 1'])
      connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Test peep 2'])
      connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Test peep 3'])

      peeps = Peep.all

      expect(peeps.length).to eq 3
      expect(peeps[0]).to be_a Peep
      expect(peeps[0].message).to eq 'Test peep 1'
      expect(peeps[1].message).to eq 'Test peep 2'
      expect(peeps[2].message).to eq 'Test peep 3'
    end
  end

  describe '.create' do
    it 'adds a peep to the database' do
      peep_1 = Peep.create(message: 'This is a new peep in unit test')
      peep_2 = Peep.create(message: 'This is another new peep in unit test')
      
      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps[0]).to be_a Peep
      expect(peeps[0].message).to eq 'This is a new peep in unit test'
      expect(peeps[0].id).to eq peep_1.id
    end
  end
end