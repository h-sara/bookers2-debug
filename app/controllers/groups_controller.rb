class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
    # @group_users = Group.find(params[:user_id])
    # @group_users = @group.group_users.select(:user_id)
    # @group_users = @group.group_users.all
    @group_users = GroupUser.all
    binding.pry
  end

  def create # グループを新規作成した際に実行
    @group = Group.new(group_params)
    @group.owner_id = current_user.id #owner_idカラムにcurrent_user.idを入れる
    if @group.save #saveが行われた場合

      # GroupUserテーブルにデータを保存する
      @group_user = GroupUser.new
      @group_user.user_id = @group.owner_id
      @group_user.group_id = @group.id
      @group_user.save

      redirect_to groups_path, notice: "You have created group successfully."
    else #saveが行われなかった場合
      render users_path
    end
  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id #グループオーナーではない場合
      redirect_to users_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "You have updated group successfully."
    else
      @users = User.all
      render "edit"
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image_id, :owner_id)
  end
end
