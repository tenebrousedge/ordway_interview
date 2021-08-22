class Seat < ApplicationRecord

  def self.from_string(str)
    new(row: str[0], column: str[1..].to_i, status: "AVAILABLE")
  end

  def ==(other)
    other.is_a?(Seat) && row == other.row && column == other.column
  end
end
