require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to have_many(:marks).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:marks) }
    it { is_expected.to accept_nested_attributes_for(:marks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
