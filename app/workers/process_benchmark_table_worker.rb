class ProcessBenchmarkTableWorker < ApplicationWorker
  SELECTOR = '.stats-table-1 tbody tr'.freeze
  CELL_SELECTOR = 'td:not(.table-title)'.freeze
  ROW_ATTRIBUTES = [
    %I[positive_months benchmark_positive_months int],
    %I[negative_months benchmark_negative_months int],
    %I[higher_return benchmark_higher_return float],
    %I[lower_return benchmark_lower_return float],
    [:above_benchmark, nil, :int],
    [:above_benchmark, nil, :int]
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
    value_cell, benchmark_value_cell = row.css(CELL_SELECTOR).to_a.last(2)
    value_attribute, benchmark_attribute, type = ROW_ATTRIBUTES[index]

    value = ExtractNumber.send(type, value_cell.text)
    benchmark_value = ExtractNumber.send(type, benchmark_value_cell&.text)

    [
      [value_attribute, value],
      [benchmark_attribute, benchmark_value]
    ]
  end
end

# <table class="stats-table-1">
#   <thead>
#     <tr>
#       <th></th>
#       <th>Fundo</th>
#       <th>CDI</th>
#     </tr>
#   </thead>
#   <tbody>
#     <tr>
#       <td class="table-title">Meses Positivos</td>
#       <td>44</td>
#       <td>69</td>
#     </tr>
#     <tr>
#       <td class="table-title">Meses Negativos</td>
#       <td>25</td>
#       <td>0</td>
#     </tr>
#     <tr>
#       <td class="table-title">Maior Retorno</td>
#       <td>14,28%</td>
#       <td>1,21%</td>
#     </tr>
#     <tr>
#       <td class="table-title">Menor Retorno</td>
#       <td>-10,06%</td>
#       <td>0,23%</td>
#     </tr>
#     <tr>
#       <td class="table-title">Acima do CDI</td>
#       <td colspan="2">38</td>
#     </tr>
#     <tr>
#       <td class="table-title">Abaixo do CDI</td>
#       <td colspan="2">31</td>
#     </tr>
#   </tbody>
# </table>