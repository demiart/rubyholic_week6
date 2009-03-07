class LocationsController < ApplicationController
  layout 'rubyholic'


protected
# this isn't DRY as this function now in locations
# and events.  My hope is to get rid of the events
# one, but i need to write this first to see through
# the problem.
  def create_group_locations_list group_id
    @group = Group.find(group_id, :include => :locations)

    # you can only create an event for a location
    # this is already attached to this group
    @group_locations_list = @group.locations.uniq.map { |location|
      [ location.name, location.id ]
    }
  end
public


  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end


  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(:controller => :events, :action => :new,
                                  :event => { :group_id => params[:group],
                                              :location_id => @location.id })}
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end



  def choose

   @location = Location.new
    begin
      create_group_locations_list params[:group]
    rescue
      #oops, someone fed us a bad group id
      flash[:notice] = "We're so sorry! We don't recognize the group you are using."
      redirect_to :controller => 'groups', :action => 'index'
      return
    end

    @all_locations = Location.find(:all).map { |location|
      [ location.name, location.id ]
    }
    @event = Event.new
    respond_to do |format|
      format.html # choose.html.erb
      format.xml  { render :xml => @all_locations }
    end
  end

end
