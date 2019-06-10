# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Model::Expense do
  let(:valid_input_data) do
    { post_date: '2019-06-10',
      title: :expense_description,
      amount: 1234,
      category: :expense_category }
  end
  let(:invalid_input_data) do
    { post_date: '',
      title: :expense_description,
      amount: '1234',
      category: :expense_category }
  end
  let(:output_data) do
    { data: Date.parse(valid_input_data[:post_date]).strftime('%d/%m/%y'),
      descricao: valid_input_data[:title],
      valor: (valid_input_data[:amount] / 100.0),
      categoria: valid_input_data[:category] }
  end

  describe '.new' do
    context 'when valid data is passed' do
      it 'set @data variable with correct format and values' do
        allow_any_instance_of(Model::ExpenseParser).to(
          receive(:call).with(valid_input_data).and_return(output_data)
        )

        instance = described_class.new(valid_input_data)

        expect(instance.data).to eql output_data
      end
    end

    context 'when invalid data is passed' do
      it 'set @data variable with correct format and values' do
        allow_any_instance_of(Model::ExpenseParser).to(
          receive(:call).with(invalid_input_data).and_raise(StandardError)
        )

        instance = described_class.new(invalid_input_data)

        expect(instance.data).to eql({})
      end
    end
  end

  describe '.to_ary' do
    context 'when valid data was passed' do
      it 'returns with correct format and values' do
        allow_any_instance_of(Model::ExpenseParser).to(
          receive(:call).with(valid_input_data).and_return(output_data)
        )

        instance = described_class.new(valid_input_data).to_ary

        expect(instance.to_ary).to eql output_data.values_at(:data, :descricao, :valor, :categoria)
      end
    end

    context 'when invalid data was passed' do
      it 'returns with correct format and values' do
        allow_any_instance_of(Model::ExpenseParser).to(
          receive(:call).with(invalid_input_data).and_raise(StandardError)
        )

        instance = described_class.new(invalid_input_data)

        expect(instance.to_ary).to eql Array.new(4, nil)
      end
    end
  end
end
