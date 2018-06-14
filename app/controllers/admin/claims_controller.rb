class Admin::ClaimsController < Admin::AdminController
  def index
    @claims = Claim.pending
  end

  def edit
  end

  def update
  end
end
