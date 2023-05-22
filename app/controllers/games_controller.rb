require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(13)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    if word_same_grid?(@letters, @word)
      if word_english?(@word)
        @answer = "Congratulation #{@word} respect all the needs. You win !"
      else
        @answer = "You loose, #{@word} is not english"
      end
    else
      @answer = "You loose, #{@word} doesnt match with #{@letters}"
    end
  end

  def word_same_grid?(letters, word)
    word.chars.all? do |letter|
      letters.count(letter) >= word.chars.count(letter)
    end
  end

  def word_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read # ouvre l'url
    user = JSON.parse(user_serialized) # parse l'APi pour la tranformer en hash
    return user['found']
  end
end
