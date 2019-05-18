class DiscoverFundsOperation
  def self.call
    new.call
  end

  def call
    rows.each { |row| enqueue_processor(row) }
  end

  private

  URL = 'https://infofundos.com.br/fundos'.freeze

  def doc
    @doc ||= begin
      request = Typhoeus::Request.get(URL)
      Nokogiri::HTML.parse(request.body)
    end
  end

  def rows
    @rows ||= Enumerator.new do |yielder|
      doc.css('table tr').each do |row|
        columns = row.css('td')
        next if columns.blank?

        yielder << columns.map(&:text)
      end
    end
  end

  def enqueue_processor(row)
    attributes = { name: row[1], tax_id: row[2].to_i, type: row[4] }
    CreateFundWorker.perform_async(attributes)
  end
end
