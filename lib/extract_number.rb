module ExtractNumber
  class << self
    MATCHER = /(-?\d+[,.]?\d+)/

    def float(str)
      parse(str)&.to_f
    end

    def int(str)
      parse(str)&.to_i
    end

    private

    def parse(str)
      return unless str.present?

      number_match = str.scan(MATCHER).flatten.first
      return unless number_match

      number_match.tr(',', '.')
    end
  end
end