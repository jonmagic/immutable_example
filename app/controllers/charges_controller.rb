class ChargesController < ApplicationController
  before_action :set_account

  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.all_for_account(@account)
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
    @charge = Charge.find_for_account(@account, params[:id])
  end

  # GET /charges/new
  def new
    @charge = Charge.new
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new do |record|
      record.amount_in_cents = params[:charge][:amount_in_cents]
      record.account_id = @account.id
    end

    respond_to do |format|
      if @charge.save
        format.html { redirect_to account_charge_path(@account, @charge), notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_account
    @account = Account.find(params[:account_id])
  end
end
