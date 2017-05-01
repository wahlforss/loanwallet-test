class MeetingsController < ApplicationController
  def new
    #get all the participants that have been added for the autocorrect.
    @participants_name_array = get_list_all_participants()
  end

  def index
    @meetings = Meeting.all
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.participants = params[:subaction] #Takes the javascript array parti
    @meeting.save
    redirect_to @meeting
  end

  def show
    @meeting = Meeting.find(params[:id])
    @participants = get_participants(@meeting)
  end
  def edit
    @meeting = Meeting.find(params[:id])
    #All participants that have been added already
    @participants = get_participants(@meeting)
    #get all the participants that have been added for the autocorrect.
    @participants_name_array = get_list_all_participants()
  end
  def update 
    @meeting = Meeting.find(params[:id])
    #All participants that have been added already
    @meeting.participants = params[:subaction]
    #was supossed to add validation, but didn't have time...
    if @meeting.update(meeting_params)
      redirect_to @meeting
    else
      render 'edit'
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect_to meetings_path
  end

  private
    def get_participants(meeting)
      #method for getting all the participants in meeting.
      participants_array = meeting.participants.split(',')
      participants = []
      participants_array.each do |p_name|
        participants.push(Participant.find_by(name: p_name))
      end
      return participants
    end

    def get_list_all_participants
       #method for getting all the participants by name in an array.
      participants = Participant.all
      participants_name_array = []
      participants.each do |p|
        participants_name_array.push(p.name)
      end
      return participants_name_array
    end
    def meeting_params
      #used for rails security. 
      params.require(:meeting).permit(:title, :participants, :room, :date)
    end
end
