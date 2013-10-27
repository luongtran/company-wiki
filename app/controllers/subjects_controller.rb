class SubjectsController < ApplicationFrontEndController

  def show
    @subject = Subject.find(params[:id])
    subject_ids = @subject.subtree_ids
    @logger.info(subject_ids)
    @posts = Post.where('subject_id in (?)', subject_ids).order('created_at DESC')
    render 'posts/index'
  end
end
