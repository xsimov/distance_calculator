class Quote

    X, Y = 0, 1

  def initialize(point_one, point_two, vehicle = nil)
    @point_one = point_one
    @point_two = point_two
    @vehicle = vehicle
  end

  def distance

    return nil if both_are_empty?
    return 0 if are_same_point? || one_is_empty?
    total_distance * apply_discount_for(@vehicle)
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

  def apply_discount_for(vehicle)
    case vehicle
    when :motorbike then 0.8
    when :car then 0.7
    when :van then 0.6
    else 1
    end
  end

end