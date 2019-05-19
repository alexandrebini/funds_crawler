namespace :funds do
  task discover: :environment do
    DiscoverFundsOperation.call
  end

  task fetch_info: :environment do
    Fund.without_info.find_each { |fund| FetchFundInfoWorker.perform_async(fund.id) }
  end

  task scrape: :environment do
    Fund.with_info.not_scraped.order(quotaholders: :desc).find_each do |fund|
      ScrapeFundPageWorker.perform_async(fund.id)
    end
  end

  task process_scaped_pages: :environment do
    Fund.scraped.find_each do |fund|
      ProcessBenchmarkTableWorker.perform_async(fund.id)
      ProcessStatsTableWorker.perform_async(fund.id)
    end
  end
end
