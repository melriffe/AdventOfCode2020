require './lib/day_13'

RSpec.describe Bus do

  subject { described_class.new bus_id, departure_time }
  let(:departure_time) { 939 }

  describe 'Bus ID 7' do
    let(:bus_id) { 7 }

    it 'has earliest departure time of 945' do
      expect(subject.earliest_departure_time).to eq 945
    end

    it 'has waiting time of 42' do
      expect(subject.waiting_time).to eq 42
    end
  end

  describe 'Bus ID 59' do
    let(:bus_id) { 59 }

    it 'has earliest departure time of 944' do
      expect(subject.earliest_departure_time).to eq 944
    end

    it 'has waiting time of 295' do
      expect(subject.waiting_time).to eq 295
    end
  end

  context 'Comparable' do
    let(:bus1) { described_class.new 7, 939 }
    let(:bus2) { described_class.new 59, 939 }

    it 'sorts by :earliest_departure_time' do
      array = [ bus1, bus2 ]
      expect(array.sort.first).to eq bus2
    end
  end
end
