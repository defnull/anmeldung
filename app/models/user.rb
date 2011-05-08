class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :adress, :email, :adress
  has_many :hosts, :dependent => :destroy

  def assemble_adress house, room_type, room, guest, app, notq, wohn
    houses = ["2","4","6","8","10","12","13"]
    if houses.include?(house)
      ##room_num[0] => floor number, room_num[1] => actual room number
      room_num = room.to_i.divmod(100)
      if room_type == "room"
        if house=="13"

        else
          if (room_num[0] > 0 && room_num[0] < 5) && (room_num[1] > 0 && room_num[1] < 15)
            self.adress = sprintf("%02d-%d",house,room)
          end
        end
      elsif room_type == "guest"
        self.adress = sprintf("%02d-02%d",house,guest)
      elsif room_type == "not"
        self.adress = sprintf("%02d-01%d",house,notq)
      elsif room_type == "app"
        self.adress = sprintf("%02d-00%d",house,app)
      elsif room_type == "wohn"
        self.adress = sprintf("%02d-03%d",house,wohn)
      end
    end
  end
end
