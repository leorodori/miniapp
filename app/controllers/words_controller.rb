class WordsController < ApplicationController
  before_action :require_login
  before_action :set_word, only: [:edit, :update, :destroy]

  def index
    @words = current_user.words
  end

  def new
    @word = current_user.words.new
  end

  def create
    @word = current_user.words.new(word_params)
    if @word.save
      redirect_to words_path, notice: "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to words_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @word.destroy
    redirect_to words_path, notice: "削除しました"
  end

  private

  def set_word
    @word = current_user.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:name)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end