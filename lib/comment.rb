# frozen_string_literal: true

require 'pg'

# This class is responsible for comments
class Comment
  attr_reader :id, :text, :created_at, :peep_id, :user_id

  def initialize(id:, text:, created_at:, peep_id:, user_id:)
    @id = id
    @text = text
    @created_at = created_at
    @peep_id = peep_id
    @user_id = user_id
  end

  def self.create(text:, peep_id:, user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params('INSERT INTO comments (text, peep_id, user_id) VALUES ($1, $2, $3) RETURNING id, text, created_at, peep_id, user_id;', [text, peep_id, user_id])
    Comment.new(id: result[0]['id'], text: result[0]['text'], created_at: result[0]['created_at'], peep_id: result[0]['peep_id'], user_id: result[0]['user_id'])
  end

  def self.find(peep_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params('SELECT * FROM comments WHERE peep_id = $1;', [peep_id])
    result.map do |comment|
      Comment.new(id: comment['id'], text: comment['text'], created_at: comment['created_at'], peep_id: comment['peep_id'], user_id: comment['user_id'])
    end
  end

  def owner(user_class = User)
    user_class.find(id: user_id)
  end
end
