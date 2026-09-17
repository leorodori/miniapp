class NotesController < ApplicationController
  before_action :set_word
  before_action :set_note, only: [:edit, :update, :destroy]

  def create
    @note = @word.notes.build(note_params)

    if @note.save
      redirect_to @word, notice: 'メモを追加しました'
    else
      redirect_to @word, alert: 'メモを追加できませんでした'
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @word, notice: 'メモを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    redirect_to @word, notice: 'メモを削除しました'
  end

  private

  def set_word
    @word = current_user.words.find(params[:word_id])
  end

  def set_note
    @note = @word.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end