require_relative '../lib/price_calc'

describe "distance calculator" do

  context 'first implementation: diagonal cost' do
    it "returns nil if there are no points jeje" do
      expect(Quote.new([],[]).calculate_price).to eq(nil)
    end

    it "returns cost 0 when it has only the first point" do
      from_point = [3, 4]
      expect(Quote.new(from_point, []).calculate_price).to eq(0)
    end

    it "returns cost 0 when it has only the second point" do
      to_point = [3, 4]
      expect(Quote.new([], to_point).calculate_price).to eq(0)
    end

    it "returns cost 0 when the points are the same" do
      from_point = [3, 4]
      to_point = from_point
      expect(Quote.new(from_point, to_point).calculate_price).to eq(0)
    end

    it "returns the difference when the points are separated only vertically" do
      from_point = [3, 4]
      to_point = [3, 14]
      expect(Quote.new(from_point, to_point).calculate_price).to eq(10)
    end

    it "returns the difference when the points are separated only horizontally" do
      from_point = [13, 4]
      to_point = [3, 4]
      expect(Quote.new(from_point, to_point).calculate_price).to eq(10)
    end

    it "returns the diagonal between points" do
      from_point = [1, 1]
      to_point = [2, 2]
      expect(Quote.new(from_point, to_point).calculate_price).to eq(Math.sqrt(2))
    end
  end

  context 'discount feature' do
    it "accepts a vehicle as the third parameter" do
      from_point = [1, 1]
      to_point = [2, 2]
      bcn_moon = Quote.new(from_point, to_point, :bike)
      expect(bcn_moon.calculate_price).to eq(Math.sqrt(2))
    end

    it "accept a discount depending on the vehicle" do
      from_point = [1, 1]
      to_point = [2, 2]
      bcn_moon = Quote.new(from_point, to_point, :motorbike)
      expect(bcn_moon.calculate_price).to eq(Math.sqrt(2)*1.2)
    end
  end

  context 'maximum distance feature' do
    it "changes the vehicle if it's not capable" do
      bcn_tgn = Quote.new([0, 0], [0, 102], :bike)
      expect{bcn_tgn.calculate_price}.to change{bcn_tgn.argument}.from(:bike).to(:car)
    end
  end

  context 'maximum capacity feature' do
    it "is capable of accepting either a vehicle or a product" do
      nord_wave = { width: 20, height: 15, length: 30 }
      bcn_tgn = Quote.new([0, 0], [0, 102], nord_wave)
      expect(bcn_tgn.argument).to eq(nord_wave)
    end

    it "chooses the vehicle depending on volume of the package" do
      nord_wave = { width: 20, height: 15, length: 30 }
      bcn_tgn = Quote.new([0, 0], [0, 102], [nord_wave])
      expect{bcn_tgn.calculate_price}.to change{bcn_tgn.argument.class}.from(Array).to(Symbol)
    end

    it "chooses the van if the volume is greater than all other vehicles" do
      nord_wave = { width: 20, height: 15, length: 50 }
      bcn_tgn = Quote.new([0, 0], [0, 102], [nord_wave])
      expect{bcn_tgn.calculate_price}.to change{bcn_tgn.argument}.from([nord_wave]).to(:van)
    end

    it "accepts two products" do
      nord_wave = { width: 20, height: 15, length: 50 }
      nord_modular = { width: 15, height: 5, length: 10 }
      bcn_tgn = Quote.new([0, 0], [0, 102], [nord_wave, nord_modular])
      expect{bcn_tgn.calculate_price}.to change{bcn_tgn.argument}.from([nord_wave, nord_modular]).to(:van)
    end
  end
end
