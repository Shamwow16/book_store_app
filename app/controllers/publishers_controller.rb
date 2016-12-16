class PublishersController < ApplicationController

  before_action :set_publisher, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      flash[:success] = "A publisher was created"
      redirect_to @publisher
    else
      flash.now[:danger] = "Publisher was not created."
      render :new
    end
  end

  def edit
  end

  def update

    if @publisher.update(publisher_params)
      flash[:success] = "Publisher has been updated"
      redirect_to @publisher
    else
      flash["danger"] = "Publisher was not updated"
      render :edit
    end
  end

  def destroy
    @publisher.destroy
    flash[:success] = "Publisher destroyed"
    redirect_to publishers_path
  end


  private
  def publisher_params
    params.require(:publisher).permit(:name)
  end

  def set_publisher
    @publisher = Publisher.find(params[:id])
  end
end
