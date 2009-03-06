class EventsController < ApplicationController
  layout 'rubyholic'

protected

  def create_locations_list group_id
    @group = Group.find(group_id, :include => :locations)

    # you can only create an event for a location
    # this is already attached to this group
    @locations_list = @group.locations.uniq.map { |location|
      [ location.name, location.id ]
    }
  end
public

  # GET /events
  # GET /events.xml
  def index
    @events = Event.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
      unless params[:group]
        # don't want to making and event unless a group
        # is given...
        flash[:notice] = 'Events must be created attached to a group'
        redirect_to :controller => 'groups', :action => 'index'
        return
      end

      unless params[:location]
        flash[:notice] = 'Please pick a location for your event.'
        redirect_to :controller => 'locations', :action => 'choose',
        :group => params[:group]
        return
      end

    @event = Event.new
    @event.location = params[:location]
    @event.group = params[:group]
#      create_locations_list params[:group]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    begin
      create_locations_list(@event.group_id)
    rescue
      flash[:notice] = 'Hmm, the event you are editing seems to have erros in it. Sorry.'
      redirect_to :controller => 'groups', :action => 'index'
    end

  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(:controller => 'groups', :action => 'show',
                                  :id => @event.group_id) }

       format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        @group = @event.group
        @locations_list = @group.locations.uniq.map { |location|
          [ location.name, location.id ]
        }

        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    group = @event.group
    @event.destroy

    respond_to do |format|
      format.html { redirect_to group }
      format.xml  { head :ok }
    end
  end
end
