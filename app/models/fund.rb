class Fund < ApplicationRecord
  self.inheritance_column = false

  scope :available, -> { where.not(qualified_investor_only: true, exclusive: true) }
  scope :viable, -> { available.where('quotaholders > ?', 50).where('patrimony > ?', 1_000_000) }

  scope :with_info, -> { where.not(slug: nil) }
  scope :without_info, -> { where(slug: nil) }
  scope :scraped, -> { where.not(html: nil) }
  scope :not_scraped, -> { where(html: nil) }

  # Fixed income
  scope :fixed_income, -> { where('type LIKE ?', '%fixa%') }
  scope :fixed_income_simple, lambda {
    fixed_income.where('sub_type LIKE ?', '%simples%')
                .or(fixed_income.where('sub_type LIKE ?', '%indexado%'))
                .or(fixed_income.where('sub_type LIKE ?', '%fixa%'))
  }
  scope :fixed_income_active, -> { fixed_income.where('sub_type LIKE ?', '%duração%') }
  scope :fixed_income_foreign, lambda {
    fixed_income.where('sub_type LIKE ?', '%exterior%')
                .or(fixed_income.where('sub_type LIKE ?', '%externa%'))
  }
  scope :fixed_income_other, lambda {
    fixed_income.where.not(id: Fund.fixed_income_simple)
                .where.not(id: Fund.fixed_income_active)
                .where.not(id: Fund.fixed_income_foreign)
  }

  # Multi Market
  scope :multi_market, -> { where('type LIKE ?', '%mercado%') }
  scope :multi_alocation, lambda {
    multi_market.where('sub_type LIKE ?', '%dinâmico%')
                .or(multi_market.where('sub_type LIKE ?', '%balanceado%'))
  }
  scope :multi_strategy, lambda {
    multi_market.where('sub_type LIKE ?', '%macro%')
                .or(multi_market.where('sub_type LIKE ?', '%trading%'))
                .or(multi_market.where('sub_type LIKE ?', '%long%'))
                .or(multi_market.where('sub_type LIKE ?', '%juros%'))
                .or(multi_market.where('sub_type LIKE ?', '%estratégia%'))
                .or(multi_market.where('sub_type LIKE ?', '%livre%'))
  }
  scope :multi_market_foreign, -> { multi_market.where('sub_type LIKE ?', '%exterior%') }
  scope :multi_market_other, lambda {
    multi_market.where.not(id: Fund.multi_alocation)
                .where.not(id: Fund.multi_strategy)
                .where.not(id: Fund.multi_market_foreign)
  }
  # Stocks
  scope :stocks, -> { where('type LIKE ?', '%ações%') }
  scope :stocks_indexed, -> { stocks.where('sub_type LIKE ?', '%indexado%') }
  scope :stocks_active, lambda {
    stocks.where('sub_type LIKE ?', '%livre%')
          .or(stocks.where('sub_type LIKE ?', '%valor%'))
          .or(stocks.where('sub_type LIKE ?', '%governança%'))
          .or(stocks.where('sub_type LIKE ?', '%caps%'))
          .or(stocks.where('sub_type LIKE ?', '%ativo%'))
          .or(stocks.where('sub_type LIKE ?', '%setoriais%'))
          .or(stocks.where('sub_type LIKE ?', '%dividendos%'))
  }
  scope :stocks_specific, lambda {
    stocks.where('sub_type LIKE ?', '%fechados%')
          .or(stocks.where('sub_type LIKE ?', '%mono%'))
  }
  scope :stocks_foreign, -> { stocks.where('sub_type LIKE ?', '%exterior%') }
  scope :stocks_other, lambda {
    stocks.where.not(id: Fund.stocks_indexed)
          .where.not(id: Fund.stocks_active)
          .where.not(id: Fund.stocks_specific)
          .where.not(id: Fund.stocks_foreign)
  }

  def scraped?
    html.present?
  end
end
