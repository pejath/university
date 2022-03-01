require 'rails_helper'

RSpec.describe FacultiesController, type: :controller do
  let!(:faculty) { create(:faculty) }

  describe '#index' do
    subject(:http_request) { get :index }

    it 'returns OK' do
      expect(http_request).to have_http_status(:success)
    end

    it 'renders the :index template' do
      expect(http_request).to render_template :index
    end
  end

  describe '#show' do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: faculty } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'takes correct faculty' do
        http_request
        expect(assigns(:faculty)).to eq faculty
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
    subject(:http_request) { get :new }

    it 'returns OK' do
      expect(http_request).to have_http_status(:success)
    end

    it 'builds new faculty' do
      http_request
      expect(assigns(:faculty)).to be_a_new(Faculty)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: faculty } }
      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits faculty record' do
        http_request
        expect(assigns(:faculty)).to eq faculty
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
      let(:params) { { faculty: attributes_for(:faculty) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates faculty' do
        expect { http_request }.to change(Faculty, :count).by(1)
      end

      it 'redirects to faculties#show' do
        expect(http_request).to redirect_to faculty_path(assigns[:faculty])
      end
    end

    context 'with invalid attributes' do
      let(:params) { { faculty: attributes_for(:invalid_faculty) } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new faculty in the database' do
        expect { http_request }.to_not change(Faculty, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:params) { { id: faculty, faculty: attributes_for(:faculty) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated faculty' do
        expect(http_request).to redirect_to faculty
      end

      it "changes faculty's attributes" do
        params[:faculty][:name] = 'Test'
        params[:faculty][:formation_date] = '1000.01.01'
        http_request
        faculty.reload
        expect(faculty.name).to eq('Test')
        expect(faculty.formation_date).to eq('1000.01.01'.to_date)
      end
    end

    context 'with invalid attributes' do
      let(:params) { { id: faculty, faculty: attributes_for(:invalid_faculty) } }

      it 'returns Not Found' do
        params['id'] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 're-renders the edit template' do
        http_request
        expect(response).to render_template :edit
      end

      it 'does not change the faculties attributes' do
        faculty_date = faculty.formation_date
        params[:faculty][:name] = 'Test'
        params[:faculty][:formation_date] = nil
        http_request
        faculty.reload
        expect(faculty.name).to_not eq('Test')
        expect(faculty.formation_date).to eq(faculty_date)
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: faculty } }
      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the faculty' do
        expect { http_request }.to change(Faculty, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to faculties_url
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
