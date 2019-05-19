class ScrapeFundPageWorker < ApplicationWorker
  def perform(fund_id)
    @fund_id = fund_id
    return if fund.blank? || fund.scraped?

    scrape
    fund.update(html: browser.html)
  ensure
    browser.close
  end

  private

  attr_reader :fund_id
  URL = 'https://maisretorno.com/fundo/%s'.freeze

  def fund
    @fund ||= Fund.find_by(id: fund_id)
  end

  def browser
    @browser ||= Watir::Browser.new(:firefox, headless: true)
  end

  def url
    @url ||= format(URL, fund.slug)
  end

  def scrape
    browser.goto(url)
    browser.wait_until { browser.element(css: ProcessBenchmarkTableWorker::SELECTOR).present? }
    browser.wait_until { browser.element(css: ProcessStatsTableWorker::SELECTOR).present? }
  end
end
