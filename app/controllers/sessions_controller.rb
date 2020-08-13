class SessionsController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show]
  
  def new
  end

  def create
    #params[:session][:email]とparams[:email]は、ともに「ユーザから送られたデータの取得」であるが、対応するモデルの有無によって[:session」が必要かどうかが変わってくる]
    email = params[:session][:email].downcase
    password = params[:session][:password].downcase
    # login(email, password)というメソッドが条件式になっているのは、後述の定義によりloginメソッドの戻り値がtrueかfalseとなっているから
    if login(email, password)
      flash[:success] = "ログインに成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    #find_byで、入力されたemailと等しいemailを持つレコードを探す
    @user = User.find_by(email: email)
    #authenticateメソッド（引数はpassword）は、@userに代入されているレコードのパスワードが正しいかを確認する
    if @user && @user.authenticate(password)
      #下記一文により、ブラウザにcookieとして、サーバーにsessionとして、ログイン状態が維持されることになります
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  
end
