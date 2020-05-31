class ChaptersController < ApplicationController
  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)
    authorize @chapter
    # if @chapter.save

    # else
    #  render :
    # end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:done)
  end
end
