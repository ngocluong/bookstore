class PaginationInfoBuilder
  attr_accessor :paginated_data

  def self.build_pagination_info(*args)
    new(*args).generate_pagination_info
  end

  def initialize(options = {})
    self.paginated_data = options[:data]
  end

  def generate_pagination_info
    OpenStruct.new(current_page: paginated_data.current_page, total_pages: paginated_data.total_pages, per_page: paginated_data.limit_value)
  end
end
