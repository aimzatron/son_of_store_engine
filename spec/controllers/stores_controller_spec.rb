require 'spec_helper'

describe StoresController do

  # This should return the minimal set of attributes required to create a valid
  # Store. As you add validations to Store, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoresController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :show, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end
  end

  describe "GET new" do
    it "assigns a new store as @store" do
      get :new, {}, valid_session
      assigns(:store).should be_a_new(Store)
    end
  end

  describe "GET edit" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :edit, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Store" do
        expect {
          post :create, {:store => valid_attributes}, valid_session
        }.to change(Store, :count).by(1)
      end

      it "assigns a newly created store as @store" do
        post :create, {:store => valid_attributes}, valid_session
        assigns(:store).should be_a(Store)
        assigns(:store).should be_persisted
      end

      it "redirects to the created store" do
        post :create, {:store => valid_attributes}, valid_session
        response.should redirect_to("http://test.host/stores/pending/")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should be_a_new(Store)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested store" do
      store = Store.create! valid_attributes
      expect {
        delete :destroy, {:id => store.to_param}, valid_session
      }.to change(Store, :count).by(-1)
    end
  end
end
