class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  # def index
  #   @students = Student.all
  # end

  def index
    #Search by major and Grad date
    Rails.logger.info "Params: #{params.inspect}"

    @search_params = params[:search] || {}
    @students = Student.all

    Rails.logger.info "Search Params: #{@search_params.inspect}"
    #If statement for major search
    if params[:show_all] == "true"
      @students = Student.all
    elsif @search_params[:major].present?
      if @search_params[:major] == 'Any Major'
        @students = Student.all
      else
        @students = @students.where(major: @search_params[:major])
      end
    end
    #If statement for grad date search
    if @search_params[:graduation_date].present? && @search_params[:graduation_date_compare].present?
      if @search_params[:graduation_date_compare] == 'before'
        @students = @students.where('graduation_date < ?', @search_params[:graduation_date])
      elsif @search_params[:graduation_date_compare] == 'after'
        @students = @students.where('graduation_date > ?', @search_params[:graduation_date])
      end
    end
    #If no major or grad date show no students
    if @search_params[:major].blank? && @search_params[:graduation_date].blank?
      @students = Student.none
    end
end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :minor, :graduation_date, :image)
    end
end
