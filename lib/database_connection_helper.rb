require 'pg'

def database_connection
  if ENV['ENVIRONMENT'] == 'test'
    PG.connect(dbname: 'chitter_sinatra_test')
  else
    PG.connect(dbname: 'chitter_sinatra')
  end
end
