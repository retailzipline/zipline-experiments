class ExperimentsController < ApplicationController
  before_action :set_experiment, only: %i[ show edit update destroy ]

  protect_from_forgery except: :show

  # GET /experiments
  def index
    @experiments = Experiment.all
  end

  # GET /experiments/1
  def show

  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  def create
    @experiment = Experiment.new(experiment_params)

    @experiment.created_by_user = User.first
    @experiment.updated_by_user = User.first

    if @experiment.save
      redirect_to @experiment, notice: "Experiment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /experiments/1
  def update
    @experiment.attributes = experiment_params

    @experiment.updated_by_user = User.first

    if @experiment.save
      redirect_to @experiment, notice: "Experiment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /experiments/1
  def destroy
    @experiment.destroy
    redirect_to experiments_url, notice: "Experiment was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def experiment_params
      params.require(:experiment).permit(:title, :description, :key, :javascript, :stylesheet, :approved, :created_by_user_id, :updated_by_user_id)
    end
end
