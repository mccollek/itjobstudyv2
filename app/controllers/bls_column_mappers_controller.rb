class BlsColumnMappersController < ApplicationController
  before_action :set_bls_column_mapper, only: [:show, :edit, :update, :destroy]

  # GET /bls_column_mappers
  # GET /bls_column_mappers.json
  def index
    @bls_column_mappers = BlsColumnMapper.all
  end

  # GET /bls_column_mappers/1
  # GET /bls_column_mappers/1.json
  def show
  end

  # GET /bls_column_mappers/new
  def new
    @bls_column_mapper = BlsColumnMapper.new
  end

  # GET /bls_column_mappers/1/edit
  def edit
  end

  # POST /bls_column_mappers
  # POST /bls_column_mappers.json
  def create
    @bls_column_mapper = BlsColumnMapper.new(bls_column_mapper_params)

    respond_to do |format|
      if @bls_column_mapper.save
        format.html { redirect_to @bls_column_mapper, notice: 'Bls column mapper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bls_column_mapper }
      else
        format.html { render action: 'new' }
        format.json { render json: @bls_column_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bls_column_mappers/1
  # PATCH/PUT /bls_column_mappers/1.json
  def update
    respond_to do |format|
      if @bls_column_mapper.update(bls_column_mapper_params)
        format.html { redirect_to @bls_column_mapper, notice: 'Bls column mapper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bls_column_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bls_column_mappers/1
  # DELETE /bls_column_mappers/1.json
  def destroy
    @bls_column_mapper.destroy
    respond_to do |format|
      format.html { redirect_to bls_column_mappers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bls_column_mapper
      @bls_column_mapper = BlsColumnMapper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bls_column_mapper_params
      params.require(:bls_column_mapper).permit(:web_column_name, :application_object, :application_object_attribute, :data_type_id)
    end
end
