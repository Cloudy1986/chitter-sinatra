# frozen_string_literal: true

require 'pg'

# This class is responsible for peeps
class Peep
  attr_reader :id, :message, :created_at, :user_id

  def initialize(id:, message:, created_at:, user_id:)
    @id = id
    @message = message
    @created_at = created_at
    @user_id = user_id
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec('SELECT * FROM peeps;')
    result.map do |peep|
      Peep.new(id: peep['id'], message: peep['message'], created_at: peep['created_at'], user_id: peep['user_id'])
    end
  end

  def self.create(message:, user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params('INSERT INTO peeps (message, user_id) VALUES ($1, $2) RETURNING id, message, created_at, user_id;', [message, user_id])
    Peep.new(id: result[0]['id'], message: result[0]['message'], created_at: result[0]['created_at'], user_id: result[0]['user_id'])
  end

  def owner(user_class = User)
    user_class.find(id: user_id)
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params("DELETE FROM peeps WHERE id = $1 RETURNING id, message, created_at, user_id;", [id])
    Peep.new(id: result[0]['id'], message: result[0]['message'], created_at: result[0]['created_at'], user_id: result[0]['user_id'])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params("SELECT * FROM peeps WHERE id = $1;", [id])
    Peep.new(id: result[0]['id'], message: result[0]['message'], created_at: result[0]['created_at'], user_id: result[0]['user_id'])
  end

end
