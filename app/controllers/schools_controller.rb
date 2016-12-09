class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  attr_accessor :count

  # GET /schools
  # GET /schools.json
  def index

    @schools = School.all

  end

  # GET /schools/1
  # GET /schools/1.json
  def show

    school = School.find(params[:id])
    school.reviews += 1
    school.save(validate: false)

  end

  # GET /schools/new
  def new
    @school = School.new

  end

  # GET /schools/1/edit
  def edit

  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    @school.password = params[:school][:password]
    @school.password_confirmation = params[:school][:password_confirmation]

    respond_to do |format|
      if @school.save

        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school ,count: 1 }


      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      @school.password = params[:school][:password]
      @school.password_confirmation = params[:school][:password_confirmation]

      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy

    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school

      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :email,:description, :location, :category, :avatar,:min_age,:max_age)
    end
end
