require 'rails_helper'

RSpec.describe LecturesController, type: :controller do
  let(:department) { create(:department) }
  let(:group) { create(:group, department: department) }
  let(:lecture_time) { create(:lecture_time) }
  let(:lec_subject) { create(:subject) }
  let(:lecturer) { create(:lecturer, department: department) }
  let!(:lecture) { create(:lecture, group: group, lecture_time: lecture_time, subject: lec_subject, lecturer: lecturer) }

  describe '#index' do
    subject(:http_request) { get :index, params: params }

    context 'with valid params' do
      let(:params) { { group_id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'renders the :index template' do
        expect(http_request).to render_template :index
      end

      it 'returns lectures in correct order' do
        10.times do
          create(:lecture, group: group, lecture_time: create(:lecture_time))
        end
        http_request
        expect(assigns(:lectures)).to eq group.lectures.includes(:lecture_time).order(:weekday).order('lecture_times.beginning')
      end
    end

    context 'with invalid group' do
      let(:params) { { group_id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#show' do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: lecture, group_id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'renders the :show template' do
        expect(http_request).to render_template :show
      end

      it 'gets correct lecture' do
        http_request
        expect(assigns(:lecture)).to eq lecture
      end
    end

    context 'with invalid params' do
      let(:params) { { id: lecture, group_id: group } }

      it 'returns Not Found' do
        params[:group_id] = -1
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
      let(:params) { { group_id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'builds new lecture' do
        http_request
        expect(assigns(:lecture)).to be_a_new(Lecture)
      end

      it 'renders the :new template' do
        expect(http_request).to render_template :new
      end
    end

    context 'with invalid group_id' do
      let(:params) { { group_id: -1 } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#edit' do
    subject(:http_request) { get :edit, params: params }

    context 'with valid params' do
      let(:params) { { id: lecture, group_id: group } }

      it 'returns OK' do
        expect(http_request).to have_http_status(:success)
      end

      it 'edits lecture record' do
        http_request
        expect(assigns(:lecture)).to eq lecture
      end

      it 'renders the :edit template' do
        expect(http_request).to render_template :edit
      end
    end

    context 'with invalid id' do
      let(:params) { { id: -1, group_id: group } }

      it 'returns Not Found' do
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    subject(:http_request) { post :create, params: params }

    context 'with valid attributes' do
      let(:create_params) { { group_id: group, lecture_time_id: create(:lecture_time), subject_id: lec_subject, lecturer_id: lecturer } }
      let(:params) { { group_id: group, lecture: attributes_for(:lecture, create_params) } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'creates lecture' do
        expect { http_request }.to change(Lecture, :count).by(1)
      end

      it 'creates lecture' do
        expect { http_request }.to change { group.reload.lectures.size }.by(1)
      end

      it 'redirects to faculties#show' do
        expect(http_request).to redirect_to group_lecture_path(group_id: group, id: assigns(:lecture))
      end
    end

    context 'with invalid attributes' do
      let(:params) { { lecture: attributes_for(:invalid_lecture), group_id: group } }

      it 'returns Unprocessable Entity' do
        expect(http_request).to have_http_status(:unprocessable_entity)
      end

      it 'does not save the new lecture in the database' do
        expect { http_request }.to_not change(Lecture, :count)
      end

      it 'does not save the new lecture in the database' do
        expect { http_request }.to_not change{ group.reload.lectures.size }
      end

      it 're-renders the :new template' do
        expect(http_request).to render_template :new
      end

      it 'returns Not Found' do
        params[:group_id] = -1
        expect(http_request).to have_http_status(:not_found)
      end
    end
  end

  describe '#update' do
    subject(:http_request) { patch :update, params: params }

    context 'with valid attributes' do
      let(:create_params) { { group_id: group.id, lecture_time_id: lecture_time.id, subject_id: lec_subject.id, lecturer_id: lecturer.id } }
      let(:params) { { id: lecture, group_id: group.id, lecture: attributes_for(:lecture, create_params) } }

      it "changes lecture's attributes" do
        params[:lecture][:weekday] = 'Tuesday'
        params[:lecture][:auditorium] = 200
        http_request
        lecture.reload
        expect(lecture.weekday).to eq 'Tuesday'
        expect(lecture.auditorium).to eq 200
      end

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'redirects to the updated lecture' do
        expect(http_request).to redirect_to group_lecture_path(group_id: group, id: lecture)
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        { id: lecture,
          group_id: group,
          lecture: attributes_for(:invalid_lecture) }
      end

      it 'does not change the faculties attributes' do
        lecture_weekday = lecture.weekday
        params[:lecture][:weekday] = 'Tuesday'
        params[:lecture][:corpus] = -1
        http_request
        lecture.reload
        expect(lecture.weekday).to_not eq('Tuesday')
        expect(lecture.corpus).to_not eq(-1)
        expect(lecture.weekday).to eq(lecture_weekday)
      end

      it 'returns Not Found' do
        params[:id] = -1
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
      let(:params) { { id: lecture, group_id: group } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end

      it 'deletes the lecture' do
        expect { http_request }.to change(Lecture, :count).by(-1)
      end

      it 'deletes the lecture' do
        expect { http_request }.to change{ group.reload.lectures.size }.by(-1)
      end

      it 'redirects to #index' do
        expect(http_request).to redirect_to group_lectures_url
      end
    end

    context 'with invalid id' do
      let(:params) { { id: -1, group_id: group } }

      it 'returns Not Found' do
        http_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
