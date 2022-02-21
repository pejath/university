require 'rails_helper'

RSpec.describe Lecturer, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:lecturers_subjects) }
    it { is_expected.to have_many(:subjects).through(:lecturers_subjects) }
    it { is_expected.to have_many(:marks).dependent(:nullify) }
    it { is_expected.to have_many(:lectures) }
    it { is_expected.to have_many(:groups).through(:lectures) }
    it { is_expected.to have_one(:curatorial_group).dependent(:nullify) }
    it { is_expected.to belong_to(:department) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to allow_value('', nil).for(:academic_degree) }
    it { is_expected.to validate_numericality_of(:academic_degree).is_greater_than(0).is_less_than(6) }
  end

  describe 'class_scopes' do
    lecturer = FactoryBot.build(:lecturer)
    group = FactoryBot.build(:group)
    it { expect(Lecturer.free_curators(group)).not_to include(lecturer) }
  end
end
