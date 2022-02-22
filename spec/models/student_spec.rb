require 'rails_helper'

RSpec.describe Student, type: :model do
  let!(:student) { build(:student, :random_student) }
  let!(:fifth_course_student) { create(:student, :fifth_course_student) }
  let!(:mark) { create(:mark, student_id: fifth_course_student.id, mark: 5) }

  describe 'relations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to have_many(:marks).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:marks) }
    it { is_expected.to accept_nested_attributes_for(:marks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'class_scope' do
    describe 'red diplomas scope' do
      it "that student shouldn't pass" do
        expect(Student.red_diplomas).not_to include(student)
      end
      it 'that student should pass' do
        expect(Student.red_diplomas).to include(fifth_course_student)
      end
    end
  end


  describe 'class_methods' do
    describe 'average mark method' do
      it 'should has average mark 0.0' do
        expect(student.average_mark).to match(0.0)
      end
      it 'should has average mark 5.0' do
        expect(fifth_course_student.average_mark).to match(5.0)
      end
      it 'should has average mark 4.5 with two marks' do
        fifth_course_student.marks << build(:mark, student_id: fifth_course_student.id, mark: 4)
        expect(fifth_course_student.average_mark).to match(4.5)
      end
    end
  end
end
