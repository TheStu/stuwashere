class GearListsController < ApplicationController
  authorize_resource

  # GET /gear_lists
  # GET /gear_lists.json
  def index
    @gear_lists = GearList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gear_lists }
    end
  end

  # GET /gear_lists/1
  # GET /gear_lists/1.json
  def show
    @gear_list = GearList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gear_list }
    end
  end

  # GET /gear_lists/new
  # GET /gear_lists/new.json
  def new
    @gear_list = GearList.new
    @gear_list.gear_listings.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gear_list }
    end
  end

  # GET /gear_lists/1/edit
  def edit
    @gear_list = GearList.find(params[:id])
    @gear_list.gear_listings.build
  end

  # POST /gear_lists
  # POST /gear_lists.json
  def create
    @gear_list = GearList.new(params[:gear_list])

    respond_to do |format|
      if @gear_list.save
        format.html { redirect_to @gear_list, notice: 'Gear list was successfully created.' }
        format.json { render json: @gear_list, status: :created, location: @gear_list }
      else
        format.html { render action: "new" }
        format.json { render json: @gear_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gear_lists/1
  # PUT /gear_lists/1.json
  def update
    @gear_list = GearList.find(params[:id])

    respond_to do |format|
      if @gear_list.update_attributes(params[:gear_list])
        format.html { redirect_to @gear_list, notice: 'Gear list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gear_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gear_lists/1
  # DELETE /gear_lists/1.json
  def destroy
    @gear_list = GearList.find(params[:id])
    @gear_list.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
