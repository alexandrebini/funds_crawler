class Fund < ApplicationRecord
  self.inheritance_column = false

  scope :info_fetched, -> { where.not(slug: nil) }
  scope :fixed_income, -> { where("type LIKE ?", "%fixa%") }
  scope :multi_market, -> { where("type LIKE ?", "%mercado%") }
  scope :stocks, -> { where("type LIKE ?", "%ações%") }
  scope :available, -> { where.not(qualified_investor_only: true, exclusive: true) }
  scope :viable, -> { available.where('quotaholders > ?', 50).where('patrimony > ?', 1_000_000) }

  scope :with_info, -> { where.not(slug: nil) }
  scope :without_info, -> { where(slug: nil) }
  scope :scraped, -> { where.not(html: nil) }
  scope :not_scraped, -> { where(html: nil) }

  def scraped?
    html.present?
  end
end
