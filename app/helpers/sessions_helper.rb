module SessionsHelper
    def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        # current_userの戻り値に対して!比較演算子を使うと、その処理の戻り値はfalseになるので、それを二回繰り返すことで
        # ログインしていれば（＝current_userメソッドの戻り値がnilでなければ）trueが返ってくる。※!nulはtrueを返す。
        !!current_user
    end

end
