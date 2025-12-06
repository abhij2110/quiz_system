class QuizzesController < ApplicationController

  def index
    @quizzes = Quiz.order(created_at: :desc)
  end

  def show
    @quiz = Quiz.includes(:questions).find(params[:id])
  end

  def submit
    @quiz = Quiz.includes(:questions).find(params[:id])
    @answers = params[:answers] || {}
    @score = 0
    @results = []

    @quiz.questions.each do |q|
      user_answer = @answers[q.id.to_s]

      correct = case q.question_type
                when "mcq", "boolean"
                  user_answer.to_s.strip.downcase == q.correct_answer.to_s.strip.downcase
                when "text"
                  user_answer.to_s.strip.downcase == q.correct_answer.to_s.strip.downcase
                end

      @score += 1 if correct

      @results << {
        question: q.question_text,
        user_answer: user_answer,
        correct_answer: q.correct_answer,
        correct: correct
      }
    end

    # Store temporarily in session (safe for small data)
    session[:quiz_score] = @score
    session[:quiz_results] = @results

    redirect_to result_quiz_path(@quiz)
  end

  def result
    @quiz = Quiz.find(params[:id])
    @score = session[:quiz_score]
    @results = session[:quiz_results]
  end


end
