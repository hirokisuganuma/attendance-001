class WorksController < ApplicationController
  def create
    @work= current_user.works.build(work_params)
    if @work.save
      flash[:success] = "出勤しました"
      redirect_to root_url
    end
  end
def show
     @user = User.find(params[:id])
    # @works = @user.works  
     if !params[:first_day].nil?
      @first_day = Date.parse(params[:first_day])
     else
      @first_day = Date.new(Date.today.year, Date.today.month)
     end
     @last_day = @first_day.end_of_month
  # 以下に＠worksを移動。＠worksには任意のユーザーの月間のデータを入れたいので、whereメソッドを使用して、絞り込みしました！
     @works = @user.works.where(day: @first_day..@last_day)#ここは理解できる
  # 以下でビューを表示する前に、１ヶ月分の勤怠レコードが存在しなかったら、１ヶ月分の勤怠レコードを作成します。
     unless @user.works.find_by(day: @first_day)#unless=条件が偽だった時の処理
       @first_day.all_month.each do |day|
         Work.create!(day: day,user_id: @user.id)#createの後ろの！は通常より強い（破壊的）メソッド
       end
     end
end
end