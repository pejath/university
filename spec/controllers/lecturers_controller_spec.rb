require 'rails_helper'

RSpec.describe LecturersController, type: :controller do
  let(:department) { create(:department) }
  let!(:lecturer) { create(:lecturer, department: department) }

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
      let(:params) { { id: lecturer } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'takes correct lecturer' do
        http_request
        expect(assigns(:lecturer)).to eq lecturer
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

    it 'builds new lecturer' do
      http_request
      expect(assigns(:lecturer)).to be_a_new(Lecturer)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: lecturer } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits lecturer record' do
        http_request
        expect(assigns(:lecturer)).to eq lecturer
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
      let(:params) { { lecturer: attributes_for(:lecturer, department_id: department) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates lecturer' do
        expect { http_request }.to change(Lecturer, :count).by(1)
      end

      it 'redirects to lecturers#show' do
        expect(http_request).to redirect_to lecturer_path(assigns[:lecturer])
      end
    end

    context 'with invalid attributes' do
      let(:params) { { lecturer: attributes_for(:invalid_lecturer) } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new lecturer in the database' do
        expect { http_request }.to_not change(Lecturer, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:params) { { id: lecturer, lecturer: attributes_for(:lecturer, department_id: department) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated lecturer' do
        expect(http_request).to redirect_to lecturer
      end

      it "changes lecturer's attributes" do
        params[:lecturer][:name] = 'Test'
        params[:lecturer][:academic_degree] = 2
        http_request
        lecturer.reload
        expect(lecturer.name).to eq('Test')
        expect(lecturer.academic_degree).to eq(2)
      end
    end

    context 'with invalid attributes' do
      let(:params) { { id: lecturer, lecturer: attributes_for(:invalid_lecturer) } }

      it 'returns Not Found' do
        params['id'] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 're-renders the edit template' do
        http_request
        expect(response).to render_template :edit
      end

      it 'does not change the lecturers attributes' do
        lecturer_name = lecturer.name
        params[:lecturer][:name] = nil
        params[:lecturer][:department_id] = 2
        http_request
        lecturer.reload
        expect(lecturer.name).to eq(lecturer_name)
        expect(lecturer.academic_degree).to_not eq(2)
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: lecturer } }
      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the lecturer' do
        expect { http_request }.to change(Lecturer, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to lecturers_url
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
