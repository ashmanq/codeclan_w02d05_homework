class Room
  # We can read and write to the name if need be
  attr_accessor :name, :room_capacity
  attr_writer :room_capacity

  def initialize(name, songs, room_capacity)
    @name = name
    @songs = songs
    @guests = []
    @room_capacity = room_capacity
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
    if @guests.find {|guest| guest == guest_to_search}
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

  def check_in_guest(new_guest)
    # If room at capacity or guest already in room then guest isnt added
    return if find_guest(new_guest)
    return if guest_count() == 10

    @guests.push(new_guest)
  end



  def remove_song(song)
    @songs.delete(song)
  end

  def check_out_guest(guest)
    @guests.delete(guest)
  end

end
