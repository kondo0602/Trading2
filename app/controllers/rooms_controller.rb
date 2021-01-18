class RoomsController < ApplicationController
  def create
    # DMのやりとりがされた場合、Roomを作成し、そのRoomでやりとりするユーザ二人分のEntryを作成する
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def update
    @room = params[:id]
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @dms = Dm.where(room_id: @room.id)
      @dm = Dm.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @rooms = []
    @current_user_entry = Entry.where(user_id: current_user.id)
    @current_user_entry.each do |entry|
      @rooms += Room.where(id: entry.room_id)
      @rooms.uniq!
    end
  end
end
