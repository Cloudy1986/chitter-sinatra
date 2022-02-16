# frozen_string_literal: true

require 'pg'
require 'bcrypt'

# This class is responsible for users
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
    result = connection.exec_params('INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id, username, email;', [username, email, encrypted_password])
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  def self.find(id:)
    return nil unless id

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params('SELECT * FROM users WHERE id = $1;', [id])
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params('SELECT * FROM users WHERE email = $1;', [email])
    return if result.any? != true
    return if BCrypt::Password.new(result[0]['password']) != password

    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end
end
