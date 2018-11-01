class FollowsController < ApplicationController
    before_action :check_follow, only: [:show, :destroy]
    before_action :follow_params, only: :create
    #homeにindexのaction移行
    def index
        #自分をfollowしているfollower一覧
        #@followed= User.eager_load(:follows).where("followed <= ?", current_user.id )
        @users = User.all
        @followids=Follow.where(follower: current_user.id)
        if @followids.any?
            @followids.each do |f|
                if @followers!=nil
                    @followers + [User.where(id: f.follower)]
                else
                    @followers = User.where(id: f.follower)
                end
            end
        else @followers==nil
        end
        #@nonfollows = User.where(@followids.followed.exists.not).all
    end

    def show
        @f_posts = Post.where(user_id: @follower.user_id)
    end
    # GET /follows/new
    #def new
       # @follow = Follow.new
    #end

    def create
        @follow = Follow.create(follower: current_user.id,followed: params[:followed])
        #@follow.follower = current_user.id
        #@follow.followed = params[:followed]
        respond_to do |format|
            format.html { redirect_to follows_path, notice: 'follow was successfully created.' }
            format.json { render :index, status: :created, location: @follow }
        '''else
            format.html { render :index }
            format.json { render json: @follow.errors, status: :unprocessable_entity }'''
        end
    end

  def destroy
    check.destroy
    flash[:notice] ='follow was successfully destroyed.'
    respond_to do |format|
    format.html { redirect_to follows_path}
    format.json { head :no_content }
    end
  end

  private
    def check_follow
        #自分だけでなくて相手からもfollowされているか確認
        check=Follow.find_by(followed: current_user.id, follower: params[:id])
        if check!=nil
            @follower = User.where(id: params[:id])
        else
            flash[:notice] = 'followされていないユーザの情報を見ることはできません'
            redirect_to follows_path
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
        params.permit(:follower, :followed)
    end
end
