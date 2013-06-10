class EntriesController < ApplicationController
  # Force JSON format in order to work with Chrome's Ripple Emulator.
  before_filter :force_json_format
  
  respond_to :json, :html
  
  def index
    respond_with Entry.all
  end
  
  def show
    respond_with Entry.find(params[:id])
  end
  
  def create
    respond_with Entry.create(params[:entry])
  end
  
  def update
    respond_with Entry.update(params[:id], params[:entry])
  end
  
  def destroy
    respond_with Entry.destroy(params[:id])
  end
  
  private
  
  def force_json_format
    request.format = :json
  end
end
