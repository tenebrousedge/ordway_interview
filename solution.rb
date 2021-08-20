Venue = Struct.new(:rows, :columns) do
  KEY = [*'a'..'z']
  def distances
    @distances ||= Array.new(rows) do |i|
      Array.new do |j|
        i + (j - (@columns / 2.0).ceil).abs
      end
    end
  end

  def seat_distance(seat)
    distances[KEY.index(seat.row)][seat.column]
  end

  def best_seat(available, k)
    available.chunk_by { |prev, subs| prev.row == subs.row && prev.column.succ == subs.column }
      .reject { |chunk| chunk.size < k }
      .map {|c| c.each_cons(k).min_by {|d| d.map(&method(:seat_distance)).each_cons(k).min_by(&:sum) }}
  end
end

Seats = Struct.new(:id, :row, :column, :status)

def venue.center
columns.
def venue.seat_distance(seat)
  row = [*"a".."z"].index(seat.row)
  d

