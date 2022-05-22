class PostCommentsController < ApplicationController
    def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
    end
    
    def destroy
      PostComment.find(params[:id]).destroy
      redirect_to book_path(params[:book_id])
      # 普通はパラメータとしてブックを入れるけど、カラムとしてのIDを引数として渡すことで定義しなくても使えるということ？
    end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
