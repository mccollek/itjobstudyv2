class ReportCriteriaController < ApplicationController
  before_action :set_report_criterium, only: [:show, :edit, :update, :destroy]

  # GET /report_criteria
  # GET /report_criteria.json
  def index
    @report_criteria = ReportCriterium.all
  end

  # GET /report_criteria/1
  # GET /report_criteria/1.json
  def show
  end

  # GET /report_criteria/new
  def new
    @report_criterium = ReportCriterium.new
  end

  # GET /report_criteria/1/edit
  def edit
  end

  # POST /report_criteria
  # POST /report_criteria.json
  def create
    @report_criterium = ReportCriterium.new(report_criterium_params)

    respond_to do |format|
      if @report_criterium.save
        format.html { redirect_to @report_criterium, notice: 'Report criterium was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report_criterium }
      else
        format.html { render action: 'new' }
        format.json { render json: @report_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_criteria/1
  # PATCH/PUT /report_criteria/1.json
  def update
    respond_to do |format|
      if @report_criterium.update(report_criterium_params)
        format.html { redirect_to @report_criterium, notice: 'Report criterium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_criteria/1
  # DELETE /report_criteria/1.json
  def destroy
    @report_criterium.destroy
    respond_to do |format|
      format.html { redirect_to report_criteria_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_criterium
      @report_criterium = ReportCriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_criterium_params
      params.require(:report_criterium).permit(:title)
    end
end
