  # ログインチェック
  def login_check
    unless user_signed_in?
      redirect_to ("/users/sign_in")
    end
  end

class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  before_action :login_check, only: [:new, :edit, :update, :destroy, :index, :show, :create]

  # 投稿一覧
  def index
    # 全データを取り出して格納
    @books = Book.all
    # Viewへ渡すためのインスタンス変数に空のモデルオブジェクトを生成
    @book = Book.new
    @newbook = Book.new
  end

  def show
    @user = current_user
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def new
  end

  # 投稿
  def create
    # ストロングパラメータ
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 条件分岐
    # DBに保存
    if @book.save
      # 投稿・一覧画面へredirect
      redirect_to book_path(@book.id)
      # サクセスメッセージ表示
      flash[:notice] = "You have creatad book successfully."
    else
      # book一覧に戻る、その際全データを取り出す
      @books = Book.all
      # ログインや入力形式に失敗、ただエラーを表示させるだけの時はrenderが主
      render("/books/index")
    end
  end

  # 編集
  def edit
    #@bookに格納
    @book = Book.find(params[:id])
  end

  # 編集更新、保存
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # book詳細へリダイレクト、controller→URL→route→controller→view
      redirect_to book_path(@book)
      # サクセスメッセージ表示
      flash[:notice] = "You have updated book successfully."
    else
      # edit画面に戻る、controller→viewでエラーを表示させるだけの時はrenderが主
      render :edit
    end
  end

  def destroy
    # データ（レコード）取得、1件
    book = Book.find(params[:id])
    # データ（レコード）を削除
    book.destroy
    # books一覧へリダイレクト、更新が必要なのでredirect
    redirect_to books_path
  end

  # 非ログインユーザーに対してのアクセス制限
  def ensure_correct_user
      @book = Book.find(params[:id])
      if user_signed_in?
        if @book.user_id != current_user.id
          redirect_to books_path
        end
      else
        redirect_to ("/users/sign_in")
      end
  end


  private
  # 投稿データ受取
  def book_params
    params.require(:book).permit(:title, :body)
  end



end
