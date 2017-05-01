class ParticipantsController < ApplicationController
  def create
    if not Participant.exists?(name: params[:participant][:name])
      #adds participant if it doesn't exist.
      @participant = Participant.new(participant_params)
      color = "#%06x" % (rand * 0xffffff) #generates random color.
      @participant.color = color
      @participant.save
    end
  end

  private
    def participant_params
      params.require(:participant).permit(:name)
    end
end
