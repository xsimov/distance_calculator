require_relative '../lib/newapp'

describe "newapp" do

  context 'first implementation: diagonal cost' do
    it "returns nil if there's no points jeje" do
      expect(Quote.new([],[]).distance).to eq(nil)
    end

    it "returns cost 0 when it has only the first point" do
      from_point = [3, 4]
      expect(Quote.new(from_point, []).distance).to eq(0)
    end

    it "returns cost 0 when it has only the second point" do
      to_point = [3, 4]
      expect(Quote.new([], to_point).distance).to eq(0)
    end

    it "returns cost 0 when the points are the same" do
      from_point = [3, 4]
      to_point = from_point
      expect(Quote.new(from_point, to_point).distance).to eq(0)
    end

    it "returns the difference when the points are separated only vertically" do
      from_point = [3, 4]
      to_point = [3, 14]
      expect(Quote.new(from_point, to_point).distance).to eq(10)
    end

    it "returns the difference when the points are separated only horizontally" do
      from_point = [13, 4]
      to_point = [3, 4]
      expect(Quote.new(from_point, to_point).distance).to eq(10)
    end

    it "returns the diagonal between points" do
      from_point = [1, 1]
      to_point = [2, 2]
      expect(Quote.new(from_point, to_point).distance).to eq(Math.sqrt(2))
    end
  end



end
