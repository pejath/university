require 'rails_helper'

RSpec.describe FacultiesController, type: :controller do
  let!(:faculty) { create(:faculty) }

  describe "#index" do
    it 'returns OK' do
      get :index
      expect(response).to have_http_status(:success)
      end

    it 'renders the :index template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#show" do
    it 'returns OK' do
      get :show, params: { id: faculty }
      expect(response).to have_http_status(:success)
      end
    it 'returns Not Found' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end

    it 'renders the :show template' do
      get :show, params: { id: faculty }
      expect(response).to render_template :show
    end
  end

  describe "#new" do
    it 'returns OK' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'builds new faculty' do
      get :new
      expect(assigns(:faculty)).to be_a_new(Faculty)
      end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    it 'returns OK' do
      get :edit, params: { id: faculty }
      expect(response).to have_http_status(:success)
    end

    it 'returns Not Found' do
      get :edit, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end

    it 'edits faculty record' do
      get :edit, params: { id: faculty }
      expect(assigns(:faculty)).to eq faculty
    end

    it 'renders the :edit template' do
      get :edit, params: { id: faculty }
      expect(response).to render_template :edit
    end
  end

  describe "#create" do
    context 'with valid attributes' do

      it 'returns Found' do
        post :create, params: {faculty: attributes_for(:faculty)}
        expect(response).to have_http_status(:found)
      end

      it 'creates faculty' do
        expect{ post :create, params: {faculty: attributes_for(:faculty)} }.to change(Faculty, :count).by(1)
      end

      it "redirects to faculties#show" do
         post :create,  params: {faculty: attributes_for(:faculty)}
         expect(response).to redirect_to faculty_path(assigns[:faculty])
      end
    end

    context "with invalid attributes" do

      it "returns Unprocessable Entity" do
        post :create, params: {faculty: attributes_for(:invalid_faculty)}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not save the new faculty in the database" do
        expect{ post :create, params: {faculty: attributes_for(:invalid_faculty)} }.to_not change(Faculty, :count)
      end

      it "re-renders the :new template" do
        post :create, params: {faculty: attributes_for(:invalid_faculty)}
        expect(response).to render_template :new
      end
    end

  end

  describe "#update" do
    context 'with valid attributes' do

      it 'returns Found' do
        patch :update, params: { id: faculty, faculty: attributes_for(:faculty)}
        expect(response).to have_http_status(:found)
      end

      it "changes faculty's attributes" do
        patch :update, params: { id: faculty,
              faculty: attributes_for(:faculty, name: 'Test', formation_date: '1000.01.01') }
        faculty.reload
        expect(faculty.name).to eq('Test')
        expect(faculty.formation_date).to eq('1000.01.01'.to_date)
      end

      it "redirects to the updated faculty" do
        patch :update, params: { id: faculty, faculty: attributes_for(:faculty) }
        expect(response).to redirect_to faculty
      end
    end

    context "with invalid attributes" do

      it 'returns Not Found' do
        patch :update, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
      end

      it "does not change the faculties attributes" do
        faculty_date = faculty.formation_date
        patch :update, params: { id: faculty,
        faculty: attributes_for(:faculty, name: 'Test', formation_date: nil ) }
        faculty.reload
        expect(faculty.name).to_not eq( 'Test' )
        expect(faculty.formation_date).to eq( faculty_date )
      end

      it "re-renders the edit template" do
        patch :update, params: { id: faculty,
          faculty: attributes_for(:invalid_faculty) }
        expect(response).to render_template :edit
      end
    end


  end

  describe '#destroy' do

    it 'returns Found' do
      delete :destroy, params: { id: faculty }
      expect(response).to have_http_status(:found)
    end

    it 'returns Not Found' do
      delete :destroy, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end

    it "deletes the faculty" do
      expect{
        delete :destroy, params: { id: faculty }
      }.to change(Faculty,:count).by(-1)
    end

    it "redirects to #index" do
      delete :destroy, params: { id: faculty }
      expect(response).to redirect_to faculties_url
    end
  end

end