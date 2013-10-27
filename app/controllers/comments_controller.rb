class CommentsController < ApplicationFrontEndController
 
  before_filter :set_subject
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment: params[:comment][:comment], user_id: current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to subject_post_path(@subject, @post), notice: 'Comment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to subject_post_path(@subject, @post), notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
