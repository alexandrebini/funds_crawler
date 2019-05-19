class FetchFundInfoWorker < ApplicationWorker
  def perform(fund_id)
    @fund_id = fund_id
    return if fund.blank?

    fund.update(remote_fund)
  end

  private

  attr_reader :fund_id

  API_URL = 'https://maisretorno.com/api/v1/fundos/sc/%s/'.freeze
  DEFAULT_HEADERS = {
    authorization: 'Basic YXBpOlIkX1hKZk1uNVdhaHlKaA=='
  }.freeze

  def fund
    @fund ||= Fund.find_by(id: fund_id)
  end

  def response
    @response ||= Typhoeus::Request.get(
      format(API_URL, fund.tax_id),
      headers: DEFAULT_HEADERS
    )
  end

  def parsed_response
    @parsed_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  def remote_fund
    @remote_fund ||= {
      name: parsed_response[:fundo_nome],
      abbr_name: parsed_response[:fundo_nome_abreviado],
      slug: parsed_response[:unique_slug],

      type: parsed_response[:cvm_classe],
      sub_type: parsed_response[:classe],

      benchmark: parsed_response[:fundo_benchmark],

      qualified_investor_only: parsed_response[:fundo_invest_qualif],
      exclusive: parsed_response[:fundo_exclusivo],
      opened: parsed_response[:fundo_cond_aberto],

      quotaholders: parsed_response[:cotistas].to_i,
      patrimony: parsed_response[:patrimonio].to_i,

      situation: parsed_response[:situacao]
    }.compact
  end
end

# API Response example
# {
#   "fundo_cnpj": 20977499000107,
#   "fundo_nome": "SANTANDER FIC FI SELECT YIELD RENDA FIXA CREDITO PRIVADO LONGO PRAZO",
#   "fundo_nome_abreviado": "SANTANDER FIC FI SELECT YIELD RF CP LP",
#   "unique_slug": "santander-fic-fi-select-yield-rf-cp-lp",
#   "fundo_cond_aberto": true,
#   "fundo_de_cotas": true,
#   "fundo_invest_qualif": false,
#   "fundo_exclusivo": false,
#   "fundo_tribut_lp": true,
#   "fundo_benchmark": "DI de um dia",
#   "admin_cnpj": 90400888000142,
#   "admin_nome": "BANCO SANTANDER (BRASIL) S.A.",
#   "gestor_cnpj": 10231177000152,
#   "gestor_nome": "SANTANDER BRASIL GESTAO DE RECURSOS LTDA",
#   "cvm_classe": "Renda Fixa",
#   "situacao": "EM FUNCIONAMENTO NORMAL",
#   "patrimonio": 1485013546.43,
#   "cotistas": 6308,
#   "classe": "Duracao Media Soberano"
# }
