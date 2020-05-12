require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }

    before { host! "localhost:3000/api" }

    describe "GET user/:id" do
        before do
            headers = { "Accept" => "application/vnd.projetofase8.v1" }
            get "/users/#{user_id}", params: {}, headers: headers
        end

        context "when the user exists" do
            it "returns the user" do
                user_response = JSON.parse(response.body)
                expect(user_response["id"]).to eq(user_id)
            end
            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the user does not exists" do
            let(:user_id){ 1000 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end
        end
   
    end

    describe "POST user/" do
        before do
            headers = { "Accept" => "application/vns.projetofase8.v1"}
            post "/users", params: { user: user_params }, headers: headers
        end
    end
end