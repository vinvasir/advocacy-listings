class Admin::ClaimsController < Admin::AdminController
  before_action :set_claim, only: [:edit, :update]

  def index
    @claims = Claim.pending
  end

  def edit
  end

  def update
    if @claim.update(claim_params)
      flash[:success] = "Successfully updated claim"
      redirect_to admin_claims_path
    else
      flash.now[:error] = "Something went wrong"
      render :edit
    end
  end

  private

    def set_claim
      @claim = Claim.find(params[:id])
    end

    def claim_params
      params.require(:claim).permit(:approved, :reason)
    end
end
