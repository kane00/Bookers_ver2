class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update]

  before_action :login_check, only: [:new, :edit, :update, :destroy, :index, :show, :create]

  def index
    # 全データ取り出して格納
    @users = User.all
    # Viewへ渡すためのインスタンス変数に空オブジェクトを生成
    @newbook = Book.new
  end


    def show
      #@userに格納
      @user = User.find(params[:id])
      # 全てのデータを取り出す
      @books = Book.all
      # Viewへ渡すための空オブジェクト生成
      @newbook = Book.new
    end

    # 編集
    def edit
      #@userに格納
      @user = User.find(params[:id])
    end

    # 更新、保存
    def update
      #@userに格納
      @user = User.find(params[:id])
      # 分岐　更新できたら
      if @user.update(user_params)
        # ユーザー画面へ更新してリダイレクト
        redirect_to user_path(@user)
        # サクセスメッセージもつける
        flash[:notice] = "You have updated user successfully."
        # うまくいかない
      else
        # edit画面へ戻る、更新はしてない
        render :edit
      end
    end

    # 非ログインユーザーに対してのアクセス制限
    def ensure_correct_user
      @user = User.find(params[:id])
      # ユーザーがサインイン済かどうかを判定
      if user_signed_in?
        # ユーザーがあっているか確認　!=は両辺が正しくない時の書き方
        if @user.id != current_user.id
          # OK・本人ならマイページにすすむ
            redirect_to user_path(current_user.id)
        end
        # 違うなら
      else
        # 新規登録画面へ
        redirect_to ("/users/sign_in")
      end
    end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def login_check
      unless user_signed_in?
        redirect_to ("/users/sign_in")
      end
  end

end
