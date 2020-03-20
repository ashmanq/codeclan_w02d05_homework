class Room
  # We can read and write to the name if need be
  attr_accessor :name, :capacity, :tab
  attr_writer :capacity

  def initialize(name, songs, room_capacity, items)
    @name = name
    @songs = songs
    @guests = []
    @capacity = room_capacity
    @items = items
    @tab = 0
  end

  def item_count()
    return @items.size()
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

  def add_to_tab(amount)
    @tab += amount
  end

  def reduce_tab(amount)
    @tab -= amount
  end

  def buy_item(item)
    add_to_tab(item.price)
  end

  # def pay_tab(guest)
  #   # We check if the guest is checked into the room
  #   if find_guest(guest.name()) && guest.enough_money?(@tab)
  #     guest.give_money(@tab)
  #     reduce_tab(@tab)
  #   end
  # end


end
