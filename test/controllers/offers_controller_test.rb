require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post :create, offer: { container: @offer.container, destination: @offer.destination, general_load: @offer.general_load, liquid_load: @offer.liquid_load, load_compensation: @offer.load_compensation, observation: @offer.observation, offer_finish_date: @offer.offer_finish_date, offer_start_date: @offer.offer_start_date, offert_type: @offer.offert_type, origins: @offer.origins, price: @offer.price, product: @offer.product, service_finish_date: @offer.service_finish_date, service_start_date: @offer.service_start_date, status: @offer.status, unit: @offer.unit, volumen: @offer.volumen }
    end

    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should show offer" do
    get :show, id: @offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer
    assert_response :success
  end

  test "should update offer" do
    patch :update, id: @offer, offer: { container: @offer.container, destination: @offer.destination, general_load: @offer.general_load, liquid_load: @offer.liquid_load, load_compensation: @offer.load_compensation, observation: @offer.observation, offer_finish_date: @offer.offer_finish_date, offer_start_date: @offer.offer_start_date, offert_type: @offer.offert_type, origins: @offer.origins, price: @offer.price, product: @offer.product, service_finish_date: @offer.service_finish_date, service_start_date: @offer.service_start_date, status: @offer.status, unit: @offer.unit, volumen: @offer.volumen }
    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete :destroy, id: @offer
    end

    assert_redirected_to offers_path
  end
end
