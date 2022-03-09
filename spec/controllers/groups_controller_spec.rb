require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:curator) { create(:lecturer) }
  let(:department) { create(:department) }
  let!(:group) { create(:group, department: department, curator: curator) }

  describe '#index' do
    subject(:http_request) { get :index }

    it 'returns OK' do
      expect(http_request).to have_http_status(:success)
    end

    it 'renders the :index template' do
      expect(http_request).to render_template :index
    end

    it 'returns groups in correct order' do
      create_list(:group, 10)
      http_request
      expect(assigns(:groups)).to eq Group.order(:department_id).all
    end
  end

  describe '#show' do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'takes correct group' do
        http_request
        expect(assigns(:group)).to eq group
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

    it 'builds new group' do
      http_request
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits group record' do
        http_request
        expect(assigns(:group)).to eq group
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
      let(:params) { { group: attributes_for(:group, department_id: department, curator_id: create(:lecturer)) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates group' do
        expect { http_request }.to change(Group, :count).by(1)
      end

      it 'redirects to groups#show' do
        expect(http_request).to redirect_to group_path(assigns[:group])
      end
    end

    context 'with invalid attributes' do
      let(:params) { { group: attributes_for(:invalid_group) } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new group in the database' do
        expect { http_request }.to_not change(Group, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:params) { { id: group, group: attributes_for(:group, department: department, curator: curator) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated group' do
        expect(http_request).to redirect_to group
      end

      it "changes group's attributes" do
        params[:group][:specialization_code] = 12
        params[:group][:form_of_education] = 'correspondence'
        http_request
        group.reload
        expect(group.specialization_code).to eq(12)
        expect(group.form_of_education).to eq('correspondence')
      end
    end

    context 'with invalid attributes' do
      let(:params) { { id: group, group: attributes_for(:invalid_group) } }

      it 'returns Not Found' do
        params['id'] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 're-renders the edit template' do
        http_request
        expect(response).to render_template :edit
      end

      it 'does not change the groups attributes' do
        groups_foe = group.form_of_education
        params[:group][:course] = 10
        params[:group][:form_of_education] = 'correspondence'
        http_request
        group.reload
        expect(group.course).to_not eq(10)
        expect(group.form_of_education).to eq(groups_foe)
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: group } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the group' do
        expect { http_request }.to change(Group, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to groups_url
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
