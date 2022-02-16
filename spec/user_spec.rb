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

end
