# Redmine Announcements plugin controller
class AnnouncementsController < ApplicationController
  unloadable

  before_filter :find_project, :except => [:hide_announcement]

  def index
    @announcements = Announcement.where(:project_id => @project)
  end

  def hide_announcement
    session[:announcement_hide_time] = Time.now
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end


  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(params[:announcement].merge({:project_id => @project.id}))

    if @announcement.save
      redirect_to announcements_path(:project_id => params[:project_id]), :notice => l(:label_announcement_created)
    else
      render :new, :notice => l(:label_error)
    end
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])

    if @announcement.update_attributes(params[:announcement])
      redirect_to announcements_url(:project_id => params[:project_id]), :notice => l(:label_announcement_updated)
    else
      render :action => "edit"
    end

  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    redirect_to announcements_url(:project_id => params[:project_id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

end

