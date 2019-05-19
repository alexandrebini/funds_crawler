class ProcessStatsTableWorker < ApplicationWorker
  SELECTOR = 'table.stats-table-2 tbody tr'.freeze
  CELL_SELECTOR = 'td:not(.table-title)'.freeze
  ROW_ATTRIBUTES = [
    %I[return_y return_12m return_24m return_36m return_all],
    %I[volatility_y volatility_12m volatility_24m volatility_36m volatility_all],
    %I[sharpe_y sharpe_12m sharpe_24m sharpe_36m sharpe_all]
  ].freeze

  def perform(fund_id)
    @fund_id = fund_id
    return if fund.blank? || !fund.scraped?
    return if attributes.blank?

    fund.update(attributes)
  end

  private

  attr_accessor :fund_id

  def fund
    @fund ||= Fund.find_by(id: fund_id)
  end

  def doc
    @doc ||= Nokogiri::HTML.parse(fund.html)
  end

  def attributes
    @attributes ||= doc.css(SELECTOR).each_with_index.map do |row, index|
      parse_row(row, index)
    end.flatten(1).to_h.compact
  end

  def parse_row(row, index)
    values = row.css(CELL_SELECTOR).map { |cell| ExtractNumber.float(cell.text) }
    row_attributes = ROW_ATTRIBUTES[index]
    Hash[row_attributes.zip(values)].compact.to_a
  end
end

# <table class="stats-table-2">
#   <thead>
#     <tr>
#       <th class="table-title"></th>
#       <th class="table-title">Ano</th>
#       <th class="table-title">12 Meses</th>
#       <th class="table-title">24 Meses</th>
#       <th class="table-title only-desk">36 Meses</th>
#       <th class="table-title">Desde o Inicio</th>
#     </tr>
#   </thead>
#   <tbody>
#     <tr>
#       <td class="table-title">Rent.</td>
#       <td>0,90%</td>
#       <td>-%</td>
#       <td>-%</td>
#       <td class="only-desk">-%</td>
#       <td>0,90%</td>
#     </tr>
#     <tr>
#       <td class="table-title">Vol.</td>
#       <td>0,22%</td>
#       <td>-%</td>
#       <td>-%</td>
#       <td class="only-desk">-%</td>
#       <td>0,22%</td>
#     </tr>
#     <tr>
#       <td class="table-title">Indice de Sharpe</td>
#       <td>-1,98</td>
#       <td>-</td>
#       <td>-</td>
#       <td class="only-desk">-</td>
#       <td>-1,98</td>
#     </tr>
#   </tbody>
# </table>
