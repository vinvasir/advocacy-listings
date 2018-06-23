class Admin::Datatable::DatatableController < Admin::AdminController
  def index
    data =  {'data' => 
        {
          'table' => builder.table_name,
          'displayable' => displayable_columns,
          'updatable' => updatable_columns,
          'records' => records.select(*displayable_columns)
        }
      }

    render json: data
  end

  def selectable_columns
    displayable_columns
  end

  def displayable_columns
    ['id']
  end

  def updatable_columns
    displayable_columns.reject {|c| c == 'id'}
  end

  protected

  def records
    search_query_params.order(id: :asc).limit(params[:limit].to_i).select(*selectable_columns)
  end

  def search_query_params
    return builder unless params.slice(:column, :operator, :value).values.reject(&:empty?).length == 3

    query_parts = resolve_query_parts(params[:operator], params[:value])
    query_parts["value"] = query_parts["value"].to_i if params[:column] == "id"

    return builder.where("#{params[:column]} #{query_parts['operator']} ?", query_parts["value"])
  end

  def resolve_query_parts(operator, value)
    query_hash = {
      "equals" => {
        "operator" => "=",
        "value" => value
      },
      "contains" => {
        "operator" => "LIKE",
        "value" => "%#{value}%"
      },
      "ends_with" => {
        "operator" => "LIKE",
        "value" => "%#{value}"          
      },
      "starts_with" => {
        "operator" => "LIKE",
        "value" => "#{value}%"             
      },
      "greater_than" => {
        "operator" => ">",
        "value" => value
      },
      "less_than" => {
        "operator" => "<",
        "value" => value
      }
    }

    query_hash[operator]
  end 
end