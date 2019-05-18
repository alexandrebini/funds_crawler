class ProcessStatsTableWorker < ApplicationWorker
  def perform(fund_id, html)
    @fund_id = fund_id
    @html = html
    return if fund.blank?

  end

  private

  attr_accessor :fund_id, :html

  def fund
    @fund ||= Fund.find_by(id: fund_id)
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
#       <th class="table-title">Desde o Início</th>
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
#       <td class="table-title">Índice de Sharpe</td>
#       <td>-1,98</td>
#       <td>-</td>
#       <td>-</td>
#       <td class="only-desk">-</td>
#       <td>-1,98</td>
#     </tr>
#   </tbody>
# </table>