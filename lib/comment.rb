require 'pg'

class Comment

  attr_reader :id, :text, :peep_id, :user_id

  def initialize(id:, text:, peep_id:, user_id:)
    @id = id
    @text = text
    @peep_id = peep_id
    @user_id = user_id
  end

  def self.create(text:, peep_id:, user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec_params("INSERT INTO comments (text, peep_id, user_id) VALUES ($1, $2, $3) RETURNING id, text, peep_id, user_id ;", [text, peep_id, user_id])
    Comment.new(id: result[0]['id'], text: result[0]['text'], peep_id: result[0]['peep_id'], user_id: result[0]['user_id'])
  end

end
