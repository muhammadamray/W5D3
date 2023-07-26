require 'connections'

class Questions
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM questions")
    data.map { |question| Questions.new(question) }
  end

  def initialize(option)
    @id = option['id']
    @title = option['title']
    @body = option['body']
    @author_id = option['author_id']
  end

  def self.find_by_id(id)
    question = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    Questions.new(question.first)
  end

  def self.find_by_author_id(author_id)
    question = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    Questions.new(question.first)
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
    Replies.find_by_question_id(self.id)
  end

end

class QuestionLikes
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map { |reply| Replies.new(reply) }
  end

  def initialize(option)
    @id = option['id']
    @user_id = option['user_id']
    @question_id = option['question_id']
  end



end

class QuestionFollows
  attr_accessor :id, :user_id, :question_id

end

class Replies
  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |reply| Replies.new(reply) }
  end

  def initialize(option)
    @id = option['id']
    @question_id = option['question_id']
    @parent_id = option['parent_id']
    @user_id = option['user_id']
    @body = option['body']
  end

  def self.find_by_id(id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Replies.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    Replies.new(reply.first)
  end

  def self.find_by_parent_id(parent_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    Replies.new(reply.first)
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Questions.find_by_id(self.question_id)
  end

  def parent_reply
    Replies.find_by_id(self.parent_id)
  end

  def child_replies
    reply = QuestionsDBConnection.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    Replies.new(reply.first)
  end

end

class Users
  attr_accessor :id, :fname, :lname
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
    data.map { |reply| Replies.new(reply) }
  end

  def initialize(option)
    @id = option['id']
    @fname = option['fname']
    @lname = option['lname']
  end

  def self.find_by_id(id)
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    Users.new(user.first)
  end

  def self.find_by_name(name)
    user = QuestionsDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
    SQL
    Users.new(user.first)
  end

  def authored_questions
    Questions.find_by_author_id(self.id)
  end

  def authored_replies
    Replies.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(self.id)
  end

end
