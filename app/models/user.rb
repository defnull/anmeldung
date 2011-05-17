class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :adress, :email, :adress
  has_many :hosts, :dependent => :destroy

  def assemble_adress house, room, special_room
    houses = ["2","4","6","8","10","12","13"]
    if houses.include?(house)
      room_type = special_room.split('_')
      if room_type[0] == "norm"
        ##room_num[0] => floor number, room_num[1] => actual room number
        room_num = room.to_i.divmod(100)
        if house=="13"
          self.adress = sprintf("%02d-%d",house,room)
        else
          if (room_num[0] > 0 && room_num[0] < 5) && (room_num[1] > 0 && room_num[1] < 15)
            self.adress = sprintf("%02d-%d",house,room)
          end
        end
      elsif room_type[0] == "guest"
        self.adress = sprintf("%02d-02%d",house,room_type[1])
      elsif room_type[0] == "not"
        self.adress = sprintf("%02d-01%d",house,room_type[1])
      elsif room_type[0] == "app"
        self.adress = sprintf("%02d-00%d",house,room_type[1])
      elsif room_type[0] == "wohn"
        self.adress = sprintf("%02d-03%d",house,room_type[1])
      end
    end
  end
end
