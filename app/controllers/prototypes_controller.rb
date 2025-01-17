class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  def edit   
    @prototype = Prototype.find(params[:id])

    unless @prototype.user == current_user
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path
    else
       render :edit, status: :unprocessable_entity

    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end
end
