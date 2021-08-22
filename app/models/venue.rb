class Venue < ApplicationRecord
  KEY = [*'a'..'z']
  def distances
        @distances ||= Array.new(rows) do |i|
      Array.new(columns) do |j|
        i + (j - (columns / 2.0).floor).abs
      end
    end
  end

  def seat_distance(seat)
    distances[KEY.index(seat.row)][seat.column.pred]
  end

  def best_seat(available, k)
    available.chunk_while { |prev, subs| prev.row == subs.row && prev.column.succ == subs.column }
      .reject { |chunk| chunk.size < k }
      .each_with_object({}) {|chunk, memo| chunk.each_cons(k).each {|s| memo[s] = s.sum(&method(:seat_distance)) }}
      .min_by { |_, v| v }
      .first
  end
end
