class FetchFundsStatsWorker < ApplicationWorker
  def perform(funds_ids)
    @funds_ids = funds_ids
    funds.find_each { |fund| visit(fund) }
  end

  private

  attr_reader :funds_ids
  URL = 'https://maisretorno.com/fundo/%s'.freeze
  BENCHMARK_TABLE_SELECTOR = 'table.stats-table-1'.freeze
  STATS_SELECTOR = 'table.stats-table-2'.freeze

  def funds
    @funds ||= Fund.where(id: funds_ids)
  end

  def browser
    @browser ||= Watir::Browser.new(:chrome, headless: true)
  end

  def visit(fund)
    url = format(URL, fund.slug)
    browser.goto(url)

    benchmark_table = browser.element(css: BENCHMARK_TABLE_SELECTOR).html
    ProcessBenchmarkTableWorker.perform_async(fund.id, benchmark_table)

    stats_table = browser.element(css: STATS_SELECTOR).html
    ProcessStatsTableWorker.perform_async(fund.id, stats_table)
  end
end
