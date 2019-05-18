class CreateFundWorker < ApplicationWorker
  def perform(attrs)
    tax_id, name, type = attrs.with_indifferent_access.values_at(:tax_id, :name, :type)
    return if Fund.where(tax_id: tax_id).exists?

    Fund.create(tax_id: tax_id,name: name,type: type)
  end
end
