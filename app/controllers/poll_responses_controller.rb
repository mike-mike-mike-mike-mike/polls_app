class PollResponsesController < ApplicationController
  before_action :set_poll_response, only: %i[show edit update destroy]
  before_action :get_poll

  # GET /poll_responses or /poll_responses.json
  def index
    @poll_responses = PollResponse.where({ poll: @poll }).all
  end

  # GET /poll_responses/1 or /poll_responses/1.json
  def show
  end

  # GET /poll_responses/new
  def new
    @poll_response = PollResponse.new({ poll: @poll })
  end

  # GET /poll_responses/1/edit
  def edit
  end

  # POST /poll_responses or /poll_responses.json
  def create
    @poll_response = PollResponse.new(poll: @poll, **poll_response_params)

    respond_to do |format|
      if @poll_response.save
        format.html { redirect_to [@poll, @poll_response], notice: "Poll response was successfully created." }
        format.json { render :show, status: :created, location: @poll_response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @poll_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poll_responses/1 or /poll_responses/1.json
  def update
    respond_to do |format|
      if @poll_response.update(poll_response_params)
        format.html { redirect_to [@poll, @poll_response], notice: "Poll response was successfully updated." }
        format.json { render :show, status: :ok, location: @poll_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poll_responses/1 or /poll_responses/1.json
  def destroy
    @poll_response.destroy!

    respond_to do |format|
      format.html { redirect_to poll_poll_responses_path, status: :see_other, notice: "Poll response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def get_poll
    @poll = Poll.find(params[:poll_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_poll_response
    @poll_response = PollResponse.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def poll_response_params
    params.require(:poll_response).permit(:answer)
  end
end
