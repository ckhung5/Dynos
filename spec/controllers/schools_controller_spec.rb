require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe SchoolsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # School. As you add validations to School, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "Elemental high school",email:"ehs@gmail.com", password: "1234567",password_confirmation:"1234567",description:"riuytrewqrtyuiyertwetuioetrwqrtuioytrefdbfanjkgsahjfkhdsjklfhasdjkfhajsdlhfjdshflkahsfjkhsdklfadsj",location:"Finland",level:"secondary_school",category:"International"}
  }

  let(:invalid_attributes) {
    {name:"Elemental high school",email: "ehsgmail.com", password: "123456",password_confirmation:"1234567",description:"riuytrewqrtyuiyertwetuioetrwqrtuioytrefdbfanjkgsahjfkhdsjklfhasdjkfhajsdlhfjdshflkahsfjkhsdklfadsj",location:"Finland",level:"secondary_school",category:"International"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SchoolsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all schools as @schools" do
      school = School.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:schools)).to eq([school])
    end
  end

  describe "GET #show" do
    it "assigns the requested school as @school" do
      school = School.create! valid_attributes

      get :show, id: school.to_param, session: valid_session
      expect(assigns(:school)).to eq(school)
    end
  end

  describe "GET #new" do
    it "assigns a new school as @school" do
      get :new, params: {}, session: valid_session
      expect(assigns(:school)).to be_a_new(School)
    end
  end

  describe "GET #edit" do
    it "assigns the requested school as @school" do
      school = School.create! valid_attributes
      get :edit, id: school.to_param, session: valid_session
      expect(assigns(:school)).to eq(school)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new School" do
        expect {
          post :create, school: valid_attributes, session: valid_session
        }.to change(School, :count).by(1)
      endx

      it "assigns a newly created school as @school" do
        post :create, school: valid_attributes, session: valid_session
        expect(assigns(:school)).to be_a(School)
        expect(assigns(:school)).to be_persisted
      end

      it "redirects to the created school" do
        post :create, school: valid_attributes, session: valid_session
        expect(response).to redirect_to(School.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved school as @school" do
        post :create, school: invalid_attributes, session: valid_session
        expect(assigns(:school)).to be_a_new(School)
      end

      it "re-renders the 'new' template" do
        post :create, school: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "CHicekn high school",email:"e22s@gmail.com", password: "1234567",password_confirmation:"1234567",description:"a2123qrtyuiyasdasdasuioytrefdbfanjkgsahjfkhdsjklfhasdjkfhajsdlhfjdshflkahsfjkhsdklfadsj",location:"Denmark",level:"secondary_school",category:"International"}
      }

      it "updates the requested school" do
        school = School.create! valid_attributes
        put :update, id: school.to_param, school: new_attributes, session: valid_session
        school.reload
        # skip("Add assertions for updated state")
      end

      it "assigns the requested school as @school" do
        school = School.create! valid_attributes
        put :update, id: school.to_param, school: valid_attributes, session: valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "redirects to the school" do
        school = School.create! valid_attributes
        put :update, id: school.to_param, school: valid_attributes, session: valid_session
        expect(response).to redirect_to(school)
      end
    end

    context "with invalid params" do
      it "assigns the school as @school" do
        school = School.create! valid_attributes
        put :update,id: school.to_param, school: invalid_attributes, session: valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "re-renders the 'edit' template" do
        school = School.create! valid_attributes
        put :update, id: school.to_param, school: invalid_attributes, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested school" do
      school = School.create! valid_attributes
      expect {
        delete :destroy, id: school.to_param, session: valid_session
      }.to change(School, :count).by(-1)
    end

    it "redirects to the schools list" do
      school = School.create! valid_attributes
      delete :destroy, id: school.to_param, session: valid_session
      expect(response).to redirect_to(schools_path)
    end
  end

end
