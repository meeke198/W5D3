require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true  #{id =>[1, 2, 3], "title" =>["Hien's", Maddie's question],ect}
        # {question_1 => [1, 'Hien's', 'HOW2MASTERSQL], question2=>[2, 'Maddie's', 'HOW2MASTERSQL]}
        #user = [{'id' => 1, 'fname' => 'Hien', lname => 'Nguyen'}]      , {'id' => 2, 'fname' => 'Maddie'}]
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
        data.map {|datum| Question.new(datum)}
    end

    def self.find_by_author_id(author_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT 
            * 
        FROM 
            questions 
        WHERE 
            author_id = ?
        SQL
        Question.new(question.first)
    end
    
    def self.find_by_id(id_num)
        question = QuestionsDatabase.instance.execute(<<-SQL, id_num)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        Question.new(question.first)
    end 
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

end


 class User
    attr_accessor :id, :fname, :lname

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT 
                *
            FROM 
                users
            WHERE 
                fname = ? AND lname = ?
        SQL
        User.new(user.first) 
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
    
 end

 class Reply 
    attr_accessor :id, :body, :parent_reply_id, :question_id, :user_id

    def self.find_by_user_id(user_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT 
                *
            FROM 
                replies
            WHERE 
                user_id = ?
        SQL
        Reply.new(reply.first)
    end

    def self.find_by_question_id(question_id)
        reply_2 = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT 
                * 
            FROM 
                replies 
            WHERE 
                question_id = ?
        SQL

        Reply.new(reply_2.first)
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @parent_reply_id = options['parent_reply_id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end



 end







