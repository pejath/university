require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let!(:faculty) { create( :faculty )}
  let!(:department) { create( :department, faculty: faculty ) }

  describe "#index" do
    it 'returns OK' do
      get :index, params: { faculty_id: faculty }
      expect(response).to have_http_status(:success)
    end

    it 'renders the :index template' do
      get :new, params: { faculty_id: faculty }
      expect(response).to render_template :new
    end
  end

  describe "#show" do
    it 'returns OK' do
      get :show, params: { id: department, faculty_id: faculty }
      expect(response).to have_http_status(:success)
    end
    it 'returns Not Found' do
      get :show, params: { id: -1, faculty_id: faculty }
      expect(response).to have_http_status(:not_found)
    end

    it 'renders the :show template' do
      get :show, params: { id: department, faculty_id: faculty }
      expect(response).to render_template :show
    end
  end

  describe "#new" do
    it 'returns OK' do
      get :new, params: { faculty_id: faculty }
      expect(response).to have_http_status(:success)
    end

    it 'builds new department' do
      get :new, params: { faculty_id: faculty }
      expect(assigns(:department)).to be_a_new(Department)
    end

    it 'renders the :new template' do
      get :new, params: { faculty_id: faculty }
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    it 'returns OK' do
      get :edit, params: { id: department, faculty_id: faculty }
      expect(response).to have_http_status(:success)
    end

    it 'returns Not Found' do
      get :edit, params: { id: -1, faculty_id: faculty }
      expect(response).to have_http_status(:not_found)
    end

    it 'edits department record' do
      get :edit, params: { id: department, faculty_id: faculty }
      expect(assigns(:department)).to eq department
    end

    it 'renders the :edit template' do
      get :edit, params: { id: department, faculty_id: faculty }
      expect(response).to render_template :edit
    end
  end

  describe "#create" do
    context 'with valid attributes' do

      it 'returns Found' do
        post :create, params: {faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty)}
        expect(response).to have_http_status(:found)
      end

      it 'creates department' do
        expect{ post :create, params: {faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty)} }.to change(Department, :count).by(1)
      end

      it "redirects to faculties#show" do
        post :create,  params: {faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty)}
        expect(response).to redirect_to faculty_department_path(faculty_id:faculty, id: Department.last)
      end
    end

    context "with invalid attributes" do

      it "returns Unprocessable Entity" do
        post :create, params: {department: attributes_for(:invalid_department), faculty_id: faculty}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not save the new department in the database" do
        expect{ post :create, params: {department: attributes_for(:invalid_department), faculty_id: faculty} }.to_not change(Department, :count)
      end

      it "re-renders the :new template" do
        post :create, params: {department: attributes_for(:invalid_department), faculty_id: faculty}
        expect(response).to render_template :new
      end
    end

  end

  describe "#update" do
    context 'with valid attributes' do

      it 'returns Found' do
        patch :update, params: { id: department, faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty)}
        expect(response).to have_http_status(:found)
      end

      it "changes department's attributes" do
        patch :update, params: { id: department, faculty_id: faculty,
                                 department: attributes_for(:department, name: 'Test', formation_date: '1000.01.01', faculty_id: faculty),
         }
        department.reload
        expect(department.name).to eq('Test')
        expect(department.faculty_id).to eq( faculty.id)
        expect(department.formation_date).to eq('1000.01.01'.to_date)
      end

      it "redirects to the updated department" do
        patch :update, params: { id: department, faculty_id: faculty, department: attributes_for(:department, faculty_id: faculty) }
        expect(response).to redirect_to faculty_department_path(faculty_id:faculty, id: Department.last)
      end
    end

    context "with invalid attributes" do

      it 'returns Not Found' do
        patch :update, params: { id: -1, faculty_id: faculty }
        expect(response).to have_http_status(:not_found)
      end

      it "does not change the faculties attributes" do
        department_date = department.formation_date
        patch :update, params: { id: department,
                                 faculty_id: faculty,
                                 department: attributes_for(:department, name: 'Test', formation_date: nil, faculty_id: faculty ) }
        department.reload
        expect(department.name).to_not eq( 'Test' )
        expect(department.faculty_id).to eq( faculty.id )
        expect(department.formation_date).to eq( department_date )
      end

      it "re-renders the edit template" do
        patch :update, params: { id: department,
                                 department: attributes_for(:invalid_department),
                                 faculty_id: faculty}
        expect(response).to render_template :edit
      end
    end


  end

  describe '#destroy' do

    it 'returns Found' do
      delete :destroy, params: { id: department, faculty_id: faculty }
      expect(response).to have_http_status(:found)
    end

    it 'returns Not Found' do
      delete :destroy, params: { id: -1, faculty_id: faculty }
      expect(response).to have_http_status(:not_found)
    end

    it "deletes the department" do
      expect{
        delete :destroy, params: { id: department, faculty_id: faculty }
      }.to change(Department, :count).by(-1)
    end

    it "redirects to #index" do
      delete :destroy, params: { id: department, faculty_id: faculty }
      expect(response).to redirect_to faculty_departments_url
    end
  end

end