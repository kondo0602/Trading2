require 'rails_helper'

RSpec.describe Dm, type: :model do
  before do
    @user_a = create(:user)
    @user_b = create(:user)
    @room = Room.create
    @entry_a = Entry.create(room_id: @room.id, user_id: @user_a.id)
    @entry_b = Entry.create(room_id: @room.id, user_id: @user_b.id)
    @dm = build(:dm, room_id: @room.id, user_id: @user_a.id)
  end

  describe 'バリデーション' do
    it 'contentとroom_idとuser_idが設定されていればOK' do
      expect(@dm.valid?).to eq(true)
    end

    it 'contentが空白だとNG' do
      @dm.content = ''
      expect(@dm.valid?).to eq(false)
    end
  end
end
