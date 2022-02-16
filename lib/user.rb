require 'pg'
require 'bcrypt'

class User

  attr_reader :id, :username, :email

  def initialize(id:, username:, email:)
    @id = id
    @username = username
    @email = email
  end

  def self.create(username:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params("INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id, username, email;", [username, email, encrypted_password])
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

end
