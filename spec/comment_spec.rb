require 'comment'

describe Comment do

  let(:user_class) { double(:user_class) }
  
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

  describe '.find' do
    it 'returns the comments for a peep' do
      user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
      peep = Peep.create(message: 'Test peep 2', user_id: user.id)
      comment_1 = Comment.create(text: 'This is a comment', peep_id: peep.id, user_id: user.id)
      comment_2 = Comment.create(text: 'This is another comment', peep_id: peep.id, user_id: user.id)

      comments = Comment.find(peep_id: peep.id)

      expect(comments.length).to eq 2
      expect(comments[0]).to be_a Comment
      expect(comments[0].text).to eq comment_1.text
      expect(comments[1].id).to eq comment_2.id
      expect(comments[0].peep_id).to eq comment_1.peep_id
      expect(comments[1].user_id).to eq comment_2.user_id
    end
  end

  describe '#owner' do
    it 'calls .find on the User class' do
      user = User.create(username: 'Mary', email: 'mary@example.com', password: 'fdbguib')
      peep = Peep.create(message: 'This is a peep', user_id: user.id)
      comment = Comment.create(text: 'This is a comment', peep_id: peep.id, user_id: user.id)

      expect(user_class).to receive(:find).with(id: comment.user_id)
      comment.owner(user_class)
    end
  end

end