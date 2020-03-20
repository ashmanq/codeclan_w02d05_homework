

class KaraokeBar
  attr_reader :name, :till, :entry_fee
  attr_writer :entry_fee

  def initialize(name, rooms, entry_fee)
    @name = name
    @rooms = rooms
    # I've assumed when a new karaoke bar is created the
    # till will start at zero
    # @till = 0
    @entry_fee = entry_fee
  end

  def room_count
    @rooms.size
  end

  # The method searches for the room by name in the rooms array.
  # If it isnt already in the room array then it adds it to the list.
  def find_room(name_of_room_to_find)
    return true if @rooms.find { |room| room.name == name_of_room_to_find }

    false
  end

  def add_room(room)
    return if find_room(room.name)

    @rooms.push(room)
  end

  def remove_room(room)
    @rooms.delete(room)
  end


  def check_guest_into_room(room, guest)
    # We look at whether the room exists, the guest can afford the entry fee, if there is enough
    # capacity in the room and if the guest hasn't already been added to the room
    # find_room(room) &&
    if find_room(room.name) && room.has_capacity? && !room.find_guest(guest.name) && guest.enough_money?(@entry_fee)
      room.add_to_tab(@entry_fee)
      room.add_guest(guest)
      if room.find_song(guest.favourite_song)
        guest_message = 'Yeeha! my fav song in da world!'
        return guest_message
      end

      guest_message = 'Aww, all duds...'
      guest_message
    end
  end


  def pay_tab(room, guest)
    # We check if the guest is checked into the room
    if room.find_guest(guest.name()) && guest.enough_money?(room.tab)
      guest.give_money(room.tab)
      room.reduce_tab(room.tab)
    end
  end
end
