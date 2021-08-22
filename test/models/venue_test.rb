require "test_helper"

class VenueTest < ActiveSupport::TestCase
  test "distance map" do
    v = Venue.new(rows: 3, columns: 3)
    expected = [[1,0,1], [2,1,2],[3,2,3]]
    assert_equal(expected, v.distances)
    v2 = Venue.new(rows: 1, columns: 5)
    expected = [[2,1,0,1,2]]
    assert_equal(expected, v2.distances)
  end

  test "seat distance" do
    v = Venue.new(rows: 5, columns: 5)
    {'a1' => 2, 'a3' => 0, 'e5' => 6}.transform_keys(&Seat.method(:from_string))
    .each do |seat, expected|
      assert_equal(expected, v.seat_distance(seat))
    end
  end

  test "best seat" do
    seats = ("a1".."a5").map(&Seat.method(:from_string))
    result = Venue.new(rows: 1, columns: 5).best_seat(seats, 1)
    assert_equal([Seat.from_string("a3")], result)
    expected = ("a2".."a4").map(&Seat.method(:from_string))
    result = Venue.new(rows: 1, columns: 5).best_seat(seats, 3)
    assert_equal(result, expected)
  end
end
