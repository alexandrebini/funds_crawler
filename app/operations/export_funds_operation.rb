class ExportFundsOperation
  def self.call(options = {})
    new(options).call
  end

  def initialize(options = {})
    @destination_path = options.fetch(:path, Rails.root.join('tmp'))
  end

  def call
    TYPES.each { |type| export(type) }
  end

  private

  attr_reader :destination_path

  TYPES = %I[
    fixed_income_simple fixed_income_active fixed_income_foreign fixed_income_other
    multi_alocation multi_strategy multi_market_foreign multi_market_other
    stocks_indexed stocks_active stocks_specific stocks_foreign stocks_other
  ].freeze
  EXLUDE_ATTRIBUTES = %w[id html].freeze

  def export(type)
    path = "#{destination_path}/#{type}.csv"
    CSV.open(path, 'wb') do |csv|
      csv << attribute_names
      Fund.send(type).find_each do |fund|
        csv << fund.attributes.except(*EXLUDE_ATTRIBUTES).values
      end
    end
  end

  def attribute_names
    @attribute_names ||= Fund.attribute_names - EXLUDE_ATTRIBUTES
  end
end
