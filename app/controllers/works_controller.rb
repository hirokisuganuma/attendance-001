class WorksController < ApplicationController
  
  def show
     @user = User.find(params[:id])
  # 一行下変更しました。
    # @works = @user.works  
    # @microposts = @user.microposts.paginate(page: params[:page])
    # @likes = Like.where(micropost_id: params[:micropost_id])
     if !params[:first_day].nil?
      @first_day = Date.parse(params[:first_day])
     else
      @first_day = Date.new(Date.today.year, Date.today.month)
     end
     @last_day = @first_day.end_of_month
  # 以下に＠worksを移動。＠worksには任意のユーザーの月間のデータを入れたいので、whereメソッドを使用して、絞り込みしました！
     @works = @user.works.where(day: @first_day..@last_day)
  # 以下でビューを表示する前に、１ヶ月分の勤怠レコードが存在しなかったら、１ヶ月分の勤怠レコードを作成します。
     unless @user.works.find_by(day: @first_day)
       @first_day.all_month.each do |day|
         Work.create!(day: day,
               user_id: @user.id)
       end
     end
     
     redirect_to(root_url) unless current_user.admin?
   end
  
  
  
  
  
  
  def create
    @work= current_user.works.build(work_params)
    if @work.save
      flash[:success] = "出勤しました"
      redirect_to root_url
    end
  end
end
