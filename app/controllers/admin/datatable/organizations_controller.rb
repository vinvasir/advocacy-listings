class Admin::Datatable::OrganizationsController < Admin::Datatable::DatatableController
  def displayable_columns
    ['id', 'title', 'mission', 'areas.name', 'category_id', 'live']
  end

  def updatable_columns
    super
  end

  def update
    @org = Organization.find(params[:id])

    if @org.update(org_params)
      render json: {success: true, org: @org}
    else
      head :error
    end
  end

  private

    def builder
      ::Organization.joins(:area).select("organizations.*, areas.*")
    end

    def org_params
      params.permit(:title, :mission, :area_id, :category_id, :live)
    end
end