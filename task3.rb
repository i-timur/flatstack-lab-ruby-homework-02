require 'open-uri'
require 'nokogiri'

class Question
  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  attr_accessor :question, :answer  
end

class Game
  def initialize
    @questions = Array.new
    parseQuestions
  end

  def parseQuestions
    url = "https://baza-otvetov.ru/categories/view/9/"
    document = Nokogiri::HTML(open(url))

    questions = document.css(".tooltip a")
    answers = document.css(".tooltip td:nth-child(3)")
    10.times do |i|
      @questions.push(Question.new(questions[i].text, answers[i].text))
    end
    22.times do |i| 
      doc = Nokogiri::HTML(open("#{url}#{(i+1) * 10}"))
      que = doc.css(".tooltip a")
      ans = doc.css(".tooltip td:nth-child(3)")
      10.times do |i|
        @questions.push(Question.new(que[i].text, ans[i].text))
      end
    end
  end

  def start
    score = 0
    while score < 1000 do
      puts "Your current score - #{score}"
      question = @questions[rand(0..@questions.length)]
      puts question.question
      ans = gets.chomp
      if ans == question.answer
        puts "Correct Answer! You get 100 points"
        score += 100
      else
        puts "Wrong Answer. Game over"
        break
      end
    end
    puts "Wanna try again?(y - yes, any input - if no)"
    dec = gets.chomp
    if dec == "y"
      start
    end
  end
end

Game.new.start