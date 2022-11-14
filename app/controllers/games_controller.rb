require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:letters]
    @result =
      if @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
        if english_word?(@answer)
          "Congratulation! #{@answer} is a valid English word."
        else
          'Not an english word'
        end
      else
        'Not in the grid'
      end
  end

  def english_word?(answer)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end
end
