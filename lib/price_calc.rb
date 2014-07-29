X, Y = 0, 1
DISTANCE, VOLUME = 1, 2
VEHICLES = {
  bike:       [  1,  10, 500],
  motorbike:  [0.8, 100, 1000],
  car:        [0.7, 200, 5000],
  van:        [0.6, 500, 10000]
}

class Quote
  attr_accessor :argument
  def initialize(point_one, point_two, argument = :bike)
    @point_one = point_one
    @point_two = point_two
    @argument = argument
  end

  def calculate_price
    return nil if both_are_empty?
    return 0 if are_same_point? || one_is_empty?
    apply_right_vehicle_for(VOLUME) unless it_can_carry_that_much?
    apply_right_vehicle_for(DISTANCE) unless it_can_go_that_far?
    total_distance * apply_discount
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

  def it_can_go_that_far?
    total_distance < VEHICLES[@argument][DISTANCE]
  end

  def it_can_carry_that_much?
    @argument.class == Symbol
  end

  def total_volume
    total_volume, product_volume = 0, 1
    @argument.each do |product|
      product.each do |key, dimension|
        product_volume *= dimension
      end
      total_volume += product_volume
    end
    total_volume
  end

  def apply_discount
    VEHICLES[@argument][0]
  end

  def apply_right_vehicle_for(parameter)
    value = (parameter == 1) ? total_distance : total_volume
    VEHICLES.each do |vehicle, max|
      return @argument = vehicle if value <= max[parameter]
      @argument = :van
    end
  end

end