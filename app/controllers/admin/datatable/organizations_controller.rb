class Admin::Datatable::OrganizationsController < Admin::Datatable::DatatableController
  def selectable_columns
    displayable_columns
  end

  def displayable_columns
    ['id', 'title', 'mission', 'areas.name as area_name', 'categories.name as category_name', 'live']
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
      ::Organization.joins(:area, :category)
    end

    def org_params
      params.permit(:title, :mission, :area_name, :category_name, :live)
    end
end