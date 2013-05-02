class GearItemsController < ApplicationController
  # GET /gear_items
  # GET /gear_items.json
  def index
    @gear_items = GearItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gear_items }
    end
  end

  # GET /gear_items/1
  # GET /gear_items/1.json
  def show
    @gear_item = GearItem.find(params[:id])
    if @gear_item.front_picture_id.present?
      @front_pic = Picture.find(@gear_item.front_picture_id)
    end
    @gear_item.get_avantlinks

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gear_item }
    end
  end

  # GET /gear_items/new
  # GET /gear_items/new.json
  def new
    @gear_item = GearItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gear_item }
    end
  end

  # GET /gear_items/1/edit
  def edit
    @gear_item = GearItem.find(params[:id])
  end

  # POST /gear_items
  # POST /gear_items.json
  def create
    @gear_item = GearItem.new(params[:gear_item])

    respond_to do |format|
      if @gear_item.save
        format.html { redirect_to @gear_item, notice: 'Gear item was successfully created.' }
        format.json { render json: @gear_item, status: :created, location: @gear_item }
      else
        format.html { render action: "new" }
        format.json { render json: @gear_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gear_items/1
  # PUT /gear_items/1.json
  def update
    @gear_item = GearItem.find(params[:id])

    respond_to do |format|
      if @gear_item.update_attributes(params[:gear_item])
        format.html { redirect_to @gear_item, notice: 'Gear item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gear_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gear_items/1
  # DELETE /gear_items/1.json
  def destroy
    @gear_item = GearItem.find(params[:id])
    @gear_item.destroy

    respond_to do |format|
      format.html { redirect_to gear_items_url }
      format.json { head :no_content }
    end
  end
end
