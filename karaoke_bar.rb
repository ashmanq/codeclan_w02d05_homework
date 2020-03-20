class KaraokeBar
  attr_reader :name, :till

  def initialize(name, rooms)
    @name = name
    @rooms = rooms
    # I've assumed when a new karaoke bar is created the
    # till will start at zero
    @till = 0
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


end
