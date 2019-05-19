namespace :funds do
  task discover: :environment do
    DiscoverFundsOperation.call
  end

  task fetch_info: :environment do
    Fund.without_info.find_each { |fund| FetchFundInfoWorker.perform_async(fund.id) }
  end

  task scrape: :environment do
    Fund.viable.with_info.not_scraped.find_each do |fund|
      ScrapeFundPageWorker.perform_async(fund.id)
    end
  end
end
