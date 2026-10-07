class FoldersController < ApplicationController
  before_action :require_login
  before_action :set_folder, only: [:edit, :update, :destroy]

  def index
    @folders = current_user.folders.order(created_at: :desc)
    @folder = current_user.folders.new
  end

  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      redirect_back fallback_location: words_path, notice: "フォルダを作成しました"
    else
      @folders = current_user.folders.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @folder.update(folder_params)
      redirect_to folders_path, notice: "フォルダ名を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @folder.destroy
    redirect_to folders_path, notice: "フォルダを削除しました"
  end

  private

  def set_folder
    @folder = current_user.folders.find_by(id: params[:id])
    unless @folder
      redirect_to folders_path, alert: "権限がありません"
    end
  end

  def folder_params
    params.require(:folder).permit(:name)
  end
end