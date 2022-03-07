require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let(:faculty) { create(:faculty) }
  let!(:department) { create(:department, faculty: faculty) }

  describe '#index' do
    subject(:http_request) { get :index, params: params }

    context 'with valid params' do
      let(:params) { { faculty_id: faculty } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'renders the :index template' do
        expect(http_request).to render_template :index
      end
    end

    context 'with invalid faculty' do
      let(:params) { { faculty_id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#show' do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: department, faculty_id: faculty } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'renders the :show template' do
        expect(http_request).to render_template :show
      end

      it 'gets correct department' do
        http_request
        expect(assigns(:department)).to eq department
      end
    end

    context 'with invalid params' do
      let(:params) { { id: department, faculty_id: faculty } }

      it 'returns Not Found' do
        params[:faculty_id] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 'returns Not Found' do
        params[:id] = -1
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#new' do
    subject(:http_request) { get :new, params: params }

    context 'with valid params' do
      let(:params) { { faculty_id: faculty } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'builds new department' do
        http_request
        expect(assigns(:department)).to be_a_new(Department)
      end

      it 'renders the :new template' do
        expect(http_request).to render_template :new
      end
    end

    context 'with invalid faculty_id' do
      let(:params) { { faculty_id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: department, faculty_id: faculty } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits department record' do
        http_request
        expect(assigns(:department)).to eq department
      end

      it 'renders the :edit template' do
        expect(http_request).to render_template :edit
      end
    end

    context 'with invalid id' do
      let(:params) { { id: -1, faculty_id: faculty } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    subject(:http_request) { post :create, params: params }

    context 'with valid attributes' do
      let(:params) { { faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates department' do
        expect { http_request }.to change(Department, :count).by(1)
      end

      it 'creates department' do
        expect { http_request }.to change{ faculty.reload.departments.size }.by(1)
      end

      it 'redirects to departments#show' do
        expect(http_request).to redirect_to faculty_department_path(faculty_id: faculty, id: assigns[:department])
      end
    end

    context 'with invalid attributes' do
      let(:params) { { department: attributes_for(:invalid_department), faculty_id: faculty } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new department in the database' do
        expect { http_request }.to_not change(Department, :count)
      end

      it 'does not save the new department in the database' do
        expect { http_request }.to_not change{ faculty.reload.departments.size }
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end

      it 'returns Not Found' do
        params[:faculty_id] = -1
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:params) do
        { id: department, faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty) }
      end

      it "changes department's attributes" do
        params[:department][:formation_date] = '1000.01.01'
        params[:department][:name] = 'Test'
        http_request
        department.reload
        expect(department.name).to eq('Test')
        expect(department.faculty_id).to eq(faculty.id)
        expect(department.formation_date).to eq('1000.01.01'.to_date)
      end

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated department' do
        expect(http_request).to redirect_to faculty_department_path(faculty_id: faculty, id: department)
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        { id: department,
          faculty_id: faculty,
          department: attributes_for(:invalid_department) }
      end

      it 'does not change the departments attributes' do
        department_date = department.formation_date
        params[:department][:name] = 'Test'
        params[:department][:formation_date] = nil
        http_request
        department.reload
        expect(department.name).to_not eq('Test')
        expect(department.faculty_id).to eq(faculty.id)
        expect(department.formation_date).to eq(department_date)
      end

      it 'returns Not Found' do
        params[:id]= -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 're-renders the edit template' do
        expect(http_request).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid params' do
      let(:params) { { id: department, faculty_id: faculty } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the department' do
        expect { http_request }.to change(Department, :count).by(-1)
      end

      it 'deletes the department' do
        expect { http_request }.to change{ faculty.reload.departments.size }.by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to faculty_departments_url
      end
    end

    context 'with invalid id' do
      let(:params) { { id: -1, faculty_id: faculty } }

      it 'returns Not Found' do
        http_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
