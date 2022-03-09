require 'rails_helper'

RSpec.describe LecturersSubjectsController, type: :controller do
  let!(:lec_subject) { create(:subject) }
  let(:department) { create(:department) }
  let!(:lecturer) { create(:lecturer, department: department) }
  let!(:lecturer_subject) { LecturersSubject.create(lecturer_id: lecturer.id, subject_id: create(:subject).id) }

  describe '#new' do
    subject(:http_request) { get :new }

    it 'returns OK' do
      expect(http_request).to have_http_status(:success)
    end

    it 'builds new lecturer_subject' do
      http_request
      expect(assigns(:lecturers_subject)).to be_a_new(LecturersSubject)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#create' do
    subject(:http_request) { post :create, params: params }

    context 'with valid attributes' do
      let(:params) { { lecturers_subject: { subject_id: lec_subject.id, lecturer_id: lecturer.id } } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates lecturer_subject' do
        expect { http_request }.to change(LecturersSubject, :count).by(1)
      end

      it 'redirects to lecturers#index' do
        expect(http_request).to redirect_to lecturers_path
      end
    end

    context 'with invalid attributes' do
      let(:params) { { lecturers_subject: { subject_id: -1, lecturer_id: -1 } } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new lecturer_subject in the database' do
        expect { http_request }.to_not change(LecturersSubject, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: lecturer_subject } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the lecturer_subject' do
        expect { http_request }.to change(LecturersSubject, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to lecturers_path
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
