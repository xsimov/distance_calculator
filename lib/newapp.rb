X, Y = 0, 1
VEHICLES_MAX = {
  bike: 10,
  motorbike: 100,
  car: 200,
  van: 500
}
VEHICLES_DISCOUNT = {
  bike: 1,
  motorbike: 0.8,
  car: 0.7,
  van: 0.6
}

class Quote

  attr_accessor :vehicle

  def initialize(point_one, point_two, vehicle = :bike)
    @point_one = point_one
    @point_two = point_two
    @vehicle = vehicle
  end

  def distance
    return nil if both_are_empty?
    return 0 if are_same_point? || one_is_empty?
    total_distance * apply_discount
  end


  def capable_of?
    total_distance < VEHICLES_MAX[@vehicle]
  end

private
  def both_are_empty?
    @point_one.empty? && @point_two.empty?
  end

  def are_same_point?
    @point_one == @point_two
  end

  def one_is_empty?
    @point_two.empty? || @point_one.empty?
  end

  def points_distance(i)
    (@point_two[i] - @point_one[i]).abs
  end

  def total_distance
    Math.sqrt(points_distance(X)**2 + points_distance(Y)**2)
  end

  def apply_discount
    VEHICLES_DISCOUNT[@vehicle]
  end

  def apply_right_vehicle
    
  end
end