class IndividualsController < ApplicationController

  before_action :require_login, :except => [:create, :new]
  before_action :require_individual, :except => [:create, :new]

  def new
    @individual = Individual.new
  end

  def create
    @individual = Individual.new(individuals_params)
    @user = User.new(user_params.merge(:role => "individual"))
    if @user.save
      @individual.user = @user
      @individual.save
      log_in @user
      flash.notice = "Welcome To Dynos"
      redirect_to edit_individual_path @individual
    else
      flash.alert = @user.errors.full_messages.first
      redirect_to new_individual_path
    end
  end

  def edit
    @individual = Individual.find_by_id(params[:id])
  end


  def update
    @individual = Individual.find_by_id(params[:id])
    respond_to do |format|
      if remotipart_submitted?
        if img_params[:bg_img]
          @individual.update(:bg_img => img_params[:bg_img]) 
        else
          @individual.update(:avatar => img_params[:avatar]) 
        end
        @individual.reload
        format.json
      else
        if @individual.update_attributes(
            :first_name => individuals_params[:first_name],
            :last_name => individuals_params[:last_name],
            :location => individuals_params[:location]
          )
          flash.notice = "Updated Successfully"
        else
          flash.notice = "Invalid Attributes"
        end
        # byebug
        format.html { redirect_to(edit_individual_path(@individual)) }
      end

    end
  end

  def destroy
    @individual = Individual.find_by_id(params[:id])
    @individual.user.destroy
    log_out

    redirect_to root_url
  end


  private
  def individuals_params
    params.require(:individual).permit(:first_name, :last_name, :location)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def img_params
    params.require(:individual).permit(:bg_img, :avatar)
  end
end
