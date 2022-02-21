require 'comment'

describe Comment do
  
  describe '.create' do
    it 'adds a comment to the database' do
      user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
      peep = Peep.create(message: 'Test peep 2', user_id: user.id)

      comment = Comment.create(text: 'This is a comment', peep_id: peep.id, user_id: user.id)

      test_connection = PG.connect(dbname: 'chitter_sinatra_test')
      test_result = test_connection.exec_params("SELECT * FROM comments WHERE peep_id = $1;", [peep.id])

      expect(comment).to be_a Comment
      expect(comment.text).to eq test_result[0]['text']
      expect(comment.peep_id).to eq test_result[0]['peep_id']
      expect(comment.user_id).to eq test_result[0]['user_id']
    end
  end

end