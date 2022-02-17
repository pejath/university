require 'rails_helper'

RSpec.describe LectureTime, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:lectures) }
  end

  describe 'validations' do
    subject { LectureTime.new(beginning: '00:00') }
    it { is_expected.to validate_uniqueness_of(:beginning) }
    it { is_expected.to validate_presence_of(:beginning) }
    it { is_expected.to allow_value('12:01').for(:beginning) }
    it { expect(subject.formatted_time).to eq('00:00')}
  end
end
