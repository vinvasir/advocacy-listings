class Admin::Datatable::PageController < Admin::AdminController
  def index
    def index
      @table = params[:table]
      @endpoint = root_path + "admin/datatable/#{@table}"
    end
  end
end