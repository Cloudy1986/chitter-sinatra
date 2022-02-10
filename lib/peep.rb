require 'pg'

class Peep

  attr_reader :id, :message

  def initialize(id:, message:)
    @id = id
    @message = message
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_sinatra_test')
    else
      connection = PG.connect(dbname: 'chitter_sinatra')
    end
    result = connection.exec("SELECT * FROM peeps;")
    result.map do |peep|
      Peep.new(id: peep['id'], message: peep['message'])
    end
  end

end