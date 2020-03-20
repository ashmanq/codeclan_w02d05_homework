class Room
  # We can read and write to the name if need be
  attr_accessor :name, :capacity
  attr_writer :capacity

  def initialize(name, songs, room_capacity)
    @name = name
    @songs = songs
    @guests = []
    @capacity = room_capacity
  end

  def song_count()
    return @songs.size()
  end

  def guest_count()
    return @guests.size()
  end

  def find_song(song_to_search)
    if @songs.find {|song| song == song_to_search}
      return true
    end
    return false
  end

  def find_guest(guest_to_search)
    if @guests.find {|guest| guest.name() == guest_to_search}
      return true
    end
    return false
  end

  def add_song(new_song)
    # If song is matches song in current list then we return
    # out of method, otherwise we add song to list.
    if find_song(new_song)
      return
    end
    @songs.push(new_song)
  end

  # def check_in_guest(new_guest, entry_fee)
  #   # If guest is already checked in to room, room at capacity or
  #   # if the guest doesnt have enough money then return false
  #   return false if find_guest(new_guest)
  #   return false if guest_count() == 10
  #   return false if new_guest.wallet < entry_fee
  #   # Otherwise add guest to room and take money from guest
  #   @guests.push(new_guest)
  #   new_guest.wallet -= entry_fee
  #   return true
  # end

  def add_guest(new_guest)
    # If guest is already checked in to room or room at capacity
    # then return false
    return false if find_guest(new_guest.name())
    return false if !has_capacity?()

    @guests.push(new_guest)
    return true
  end

  def has_capacity?()
    return @guests.size() < @capacity
  end



  def remove_song(song)
    @songs.delete(song)
  end

  def remove_guest(guest)
    @guests.delete(guest)
  end

end
