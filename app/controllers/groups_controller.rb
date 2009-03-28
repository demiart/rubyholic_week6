class GroupsController < ApplicationController
  layout 'rubyholic'

  # GET /groups
  # GET /groups.xml
  def index
    @groups = Group.paginate :page => params[:page], :per_page => 5,
    :order => 'name'



    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @sort = params[:sort_events_by] || 'name'
    @sort = 'name' unless %w(name start_time locationname ).include? @sort

    @group = Group.find(params[:id])


    @events = Event.paginate(:all,
                             :select => 'events.name, events.id, events.start_time,
                             events.location_id, locations.name as locationname',
                             :joins => [ :location],
                             :conditions => ['group_id=?', params[:id]],
                             :group => :name,
                             :order => @sort,
                             :page => params[:page],
                             :per_page => 10)

    @event = Event.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    Group.transaction do
      @group = Group.find(params[:id])
      @group.events.each {|event|
        event.destroy
      }
      @group.destroy
    end
   
    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
