require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:group) { create(:group, course: 5) }
  let!(:student) { create(:student, group: group) }
  let!(:red_diploma_student) { create(:student, :with_red_diploma, group: group) }

  describe '#index' do
    subject(:http_request) { get :index, params: params }

    context 'with params' do
      let(:params) { {} }

      it 'returns red diploma student' do
        params[:red_diplomas] = true
        http_request
        expect(assigns(:students)).to include(red_diploma_student)
        expect(assigns(:students)).to_not include(student)
      end

      it 'returns student from group' do
        params[:group_id] = group.id
        http_request
        expect(assigns(:students)).to include(red_diploma_student)
        expect(assigns(:students)).to include(student)
      end

      it 'returns student from group' do
        params[:group_id] = group.id
        params[:red_diplomas] = true
        http_request
        expect(assigns(:students)).to include(red_diploma_student)
        expect(assigns(:students)).to_not include(student)
      end

      it 'returns student from group in correct order' do
        http_request
        expect(assigns(:students)).to eq Student.order(:group_id).all
      end
    end

    context 'without params' do
      let(:params) {}

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'renders the :index template' do
        expect(http_request).to render_template :index
      end
    end
  end

  describe '#show' do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: student } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'takes correct student' do
        http_request
        expect(assigns(:student)).to eq student
      end

      it 'renders the :show template' do
        expect(http_request).to render_template :show
      end
    end

    context 'with invalid params' do
      let(:params) { { id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#new' do
    subject(:http_request) { get :new, params: params}
    let(:params) { { student: attributes_for(:student, group: group) } }

    it 'returns OK' do
      expect(http_request).to have_http_status(:success)
    end

    it 'builds new student' do
      http_request
      expect(assigns(:student)).to be_a_new(Student)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: student} }
      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits student record' do
        http_request
        expect(assigns(:student)).to eq student
      end

      it 'renders the :edit template' do
        expect(http_request).to render_template :edit
      end

    end

    context 'with invalid params' do
      let(:params) { { id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    subject(:http_request) { post :create, params: params }

    context 'with valid attributes' do
      let(:mark) { build(:mark, lecturer: create(:lecturer), subject: create(:subject)).attributes }
      let(:params) { { student: attributes_for(:student, group_id: group, marks_attributes: [mark]) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates student' do
        expect { http_request }.to change(Student, :count).by(1)
      end

      it 'redirects to faculties#show' do
        expect(http_request).to redirect_to student_path(assigns[:student])
      end

      it 'adds mark to the student' do
        expect { http_request }.to change(Mark, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:params) { { student: attributes_for(:invalid_student) } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new student in the database' do
        expect { http_request }.to_not change(Student, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:mark) { build(:mark, lecturer: create(:lecturer), subject: create(:subject)).attributes }
      let(:ex_params) { { student: attributes_for(:student, group_id: group, marks_attributes: [id: 1, _destroy: true]) }}
      let(:params) { { id: student, student: attributes_for(:student, group_id: group, marks_attributes: [mark]) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated student' do
        expect(http_request).to redirect_to student
      end

      it "changes student's attributes" do
        params[:student][:name] = 'Bill'
        http_request
        student.reload
        expect(student.name).to eq('Bill')
      end

      it 'creates marks for the student' do
        expect { http_request }.to change(Mark, :count).by(1)
        expect(student.marks.size).to eq(1)
      end

      it 'destroys marks for the student' do
        params[:student] = ex_params[:student]
        params[:id] = red_diploma_student
        http_request
        expect(red_diploma_student.marks.size).to eq(0)
      end
    end

    context 'with invalid attributes' do
      let(:params) { { id: student, student: attributes_for(:invalid_faculty) } }

      it 'returns Not Found' do
        params['id'] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 're-renders the edit template' do
        http_request
        expect(response).to render_template :edit
      end

      it 'does not change the faculties attributes' do
        students_name = student.name
        params[:student][:name] = 'Test'
        params[:student][:group_id] = -1
        http_request
        student.reload
        expect(student.name).to_not eq('Test')
        expect(student.name).to eq(students_name)
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: student } }
      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the student' do
        expect { http_request }.to change(Student, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to students_url
      end
    end

    context 'with invalid id' do
      let(:params) { { id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end
end
