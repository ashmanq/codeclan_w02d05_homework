class KaraokeBar
  attr_reader :name, :till, :entry_fee
  attr_writer :entry_fee

  def initialize(name, rooms, entry_fee)
    @name = name
    @rooms = rooms
    # I've assumed when a new karaoke bar is created the
    # till will start at zero
    @till = 0
    @entry_fee = entry_fee
  end

  def room_count()
    return @rooms.size()
  end

  # The method searches for the room by name in the rooms array.
  # If it isnt already in the room array then it adds it to the list.
  def find_room(name_of_room_to_find)
    if @rooms.find {|room| room.name() == name_of_room_to_find}
      return true
    end
    return false
  end

  def add_room(room)
    if find_room(room.name())
      return
    end
    @rooms.push(room)
  end

  def remove_room(room)
    @rooms.delete(room)
  end

  def add_to_till(amount)
    @till += amount
  end

  def check_guest_into_room(room, guest)
    # We look at whether the guest can afford the entry fee, if there is enough
    # capacity in the room and if the guest hasn't already been added to the room
    if room.has_capacity? && guest.enough_money?(@entry_fee) && !room.find_guest(guest.name())
      guest.give_money(@entry_fee)
      @till += @entry_fee
      room.add_guest(guest)
    end
  end


end
