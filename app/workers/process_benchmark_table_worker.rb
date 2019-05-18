class ProcessBenchmarkTableWorker < ApplicationWorker
  def perform(fund_id, html)
    @fund_id = fund_id
    @html = html
    return if fund.blank?

  end

  private
  SELECTOR = 'table.stats-table-1'.freeze
  attr_accessor :fund_id, :html

  def fund
    @fund ||= Fund.find_by(id: fund_id)
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