# frozen_string_literal: true

require 'peep'

describe Peep do
  let(:user_class) { double(:user_class) }

  describe '.all' do
    it 'returns a list of peeps with message and created_at attributes' do
      user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
      peep = Peep.create(message: 'Test peep 1', user_id: user.id)
      Peep.create(message: 'Test peep 2', user_id: user.id)
      Peep.create(message: 'Test peep 3', user_id: user.id)

      peeps = Peep.all

      expect(peeps.length).to eq 3
      expect(peeps[0]).to be_a Peep
      expect(peeps[0].message).to eq 'Test peep 1'
      expect(peeps[1].message).to eq 'Test peep 2'
      expect(peeps[2].message).to eq 'Test peep 3'
      expect(peeps[0].created_at).to eq peep.created_at
      expect(peeps[0].user_id).to eq user.id
    end
  end

  describe '.create' do
    it 'adds a peep to the database' do
      user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')

      peep = Peep.create(message: 'This is a new peep in unit test', user_id: user.id)
      Peep.create(message: 'This is another new peep in unit test', user_id: user.id)
      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps[0]).to be_a Peep
      expect(peeps[0].message).to eq 'This is a new peep in unit test'
      expect(peeps[0].id).to eq peep.id
      expect(peeps[0].user_id).to eq user.id
    end
  end

  describe '#owner' do
    it 'calls .find on the User class' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: 'fdbguib')
      peep = Peep.create(message: 'This is a peep', user_id: user.id)

      expect(user_class).to receive(:find).with(id: peep.user_id)
      peep.owner(user_class)
    end
  end

  describe '.delete' do
    it 'deletes a peep from the database by an id' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: 'fdbguib')
      peep = Peep.create(message: 'This is a test peep', user_id: user.id)

      deleted_peep = Peep.delete(id: peep.id)
      peeps = Peep.all

      expect(peeps).to be_empty
      expect(deleted_peep.id).to eq peep.id
      expect(deleted_peep.user_id).to eq user.id
    end
  end

  describe '.find' do
    it 'returns a peep by id' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: 'fdbguib')
      peep = Peep.create(message: 'This is a test peep', user_id: user.id)

      returned_peep = Peep.find(id: peep.id)

      expect(returned_peep).to be_a Peep
      expect(returned_peep.id).to eq peep.id
      expect(returned_peep.message).to eq peep.message
      expect(returned_peep.user_id).to eq peep.user_id
    end
  end

  describe '.update' do
    it 'updates a peep in the database' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: 'fdbguib')
      peep = Peep.create(message: 'This is a test peep', user_id: user.id)

      updated_peep = Peep.update(id: peep.id, message: 'This is an updated peep')

      expect(updated_peep).to be_a Peep
      expect(updated_peep.id).to eq peep.id
      expect(updated_peep.user_id).to eq peep.user_id
      expect(updated_peep.message).to eq 'This is an updated peep'
    end
  end
end
