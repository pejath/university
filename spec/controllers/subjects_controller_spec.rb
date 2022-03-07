require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let!(:lec_subject) { create(:subject) }

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
      let(:params) { { id: lec_subject } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'takes correct subject' do
        http_request
        expect(assigns(:subject)).to eq lec_subject
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

    it 'builds new subject' do
      http_request
      expect(assigns(:subject)).to be_a_new(Subject)
    end

    it 'renders the :new template' do
      expect(http_request).to render_template :new
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: lec_subject } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits subject record' do
        http_request
        expect(assigns(:subject)).to eq lec_subject
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
      let(:params) { { subject: attributes_for(:subject) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates subject' do
        expect { http_request }.to change(Subject, :count).by(1)
      end

      it 'redirects to subjects#show' do
        expect(http_request).to redirect_to subject_path(assigns[:subject])
      end
    end

    context 'with invalid attributes' do
      let(:params) { { subject: attributes_for(:invalid_subject) } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new subject in the database' do
        expect { http_request }.to_not change(Subject, :count)
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:params) { { id: lec_subject, subject: attributes_for(:subject) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated subject' do
        expect(http_request).to redirect_to lec_subject
      end

      it "changes subject's attributes" do
        params[:subject][:name] = 'Test'
        http_request
        lec_subject.reload
        expect(lec_subject.name).to eq('Test')
      end
    end

    context 'with invalid attributes' do
      let(:params) { { id: lec_subject, subject: attributes_for(:invalid_subject) } }

      it 'returns Not Found' do
        params['id'] = -1
        expect(http_request).to have_http_status(:not_found)
      end

      it 're-renders the edit template' do
        http_request
        expect(response).to render_template :edit
      end

      it 'does not change the subject\'s attributes' do
        subject_name = lec_subject.name
        params[:subject][:name] = nil
        http_request
        lec_subject.reload
        expect(lec_subject.name).to_not eq(nil)
        expect(lec_subject.name).to eq(subject_name)
      end
    end
  end

  describe '#destroy' do
    subject(:http_request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { { id: lec_subject } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the subject' do
        expect { http_request }.to change(Subject, :count).by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to subjects_url
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
