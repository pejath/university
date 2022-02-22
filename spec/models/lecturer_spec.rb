require 'rails_helper'

RSpec.describe Lecturer, type: :model do
  let!(:lecturer) { FactoryBot.build(:lecturer) }
  let!(:curator) { FactoryBot.create(:lecturer) }
  let!(:group) { FactoryBot.build(:group, curator_id: curator.id) }

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
    describe 'free_curators scope' do
      it 'group should has another curator' do
        expect(Lecturer.free_curators(group)).not_to include(lecturer)
      end
      it 'group should has this lecturer as curator' do
        expect(Lecturer.free_curators(group)).to include(curator)
      end
    end
  end
end
