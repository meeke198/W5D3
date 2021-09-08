require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true  #{id =>[1, 2, 3], "title" =>["Hien's", Maddie's question],ect}
        # {question_1 => [1, 'Hien's', 'HOW2MASTERSQL], question2=>[2, 'Maddie's', 'HOW2MASTERSQL]}
    end
end

class Question
    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
        data.map {|datum| Question.new(datum)}
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
def 

end

# class User
    
# end
# class Reply
    
# end
