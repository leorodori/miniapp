class NotesController < ApplicationController
  before_action :set_word

  def create
    @note = @word.notes.build(note_params)

    if @note.save
      redirect_to @word, notice: 'メモを追加しました'
    else
      redirect_to @word, alert: 'メモを追加できませんでした'
    end
  end

  private

  def set_word
    @word = current_user.words.find(params[:word_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end