require 'user'

describe User do
  
  describe '.create' do
    it 'adds a user to the database when user signs up' do
      user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')

      test_connection = PG.connect(dbname: 'chitter_sinatra_test')
      test_result = test_connection.exec_params("SELECT * FROM users WHERE id = $1;", [user.id])

      expect(user).to be_a User
      expect(user.id).to eq test_result[0]['id']
      expect(user.username).to eq test_result[0]['username']
      expect(user.email).to eq test_result[0]['email']
    end

    it "encrypts the password" do
      expect(BCrypt::Password).to receive(:create).with('password1234')
      User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    end
  end

  describe '.find' do
    it 'returns a user by their id' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: '1234password')
      returned_user = User.find(id: user.id)

      expect(returned_user).to be_a User
      expect(returned_user.id).to eq user.id
      expect(returned_user.username).to eq user.username
      expect(returned_user.email).to eq user.email
    end
  end

end
