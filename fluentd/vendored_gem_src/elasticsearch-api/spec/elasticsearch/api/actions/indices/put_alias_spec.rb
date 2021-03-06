# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

require 'spec_helper'

describe 'client.cluster#put_alias' do

  let(:expected_args) do
    [
        'PUT',
        url,
        {},
        body,
        nil
    ]
  end

  let(:url) do
    'foo/_aliases/bar'
  end

  let(:body) do
    nil
  end

  it 'performs the request' do
    expect(client_double.indices.put_alias(index: 'foo', name: 'bar')).to eq({})
  end

  context 'when there is no name specified' do

    let(:client) do
      Class.new { include Elasticsearch::API }.new
    end

    it 'raises an exception' do
      expect {
        client.indices.put_alias(name: 'foo')
      }.to raise_exception(ArgumentError)
    end
  end

  context 'when a body is specified' do

    let(:body) do
      { filter: 'foo' }
    end

    it 'performs the request' do
      expect(client_double.indices.put_alias(index: 'foo', name: 'bar', body: { filter: 'foo' })).to eq({})
    end
  end

  context 'when multiple indices are specified' do

    let(:url) do
      'foo,bar/_aliases/bam'
    end

    it 'performs the request' do
      expect(client_double.indices.put_alias(index: ['foo','bar'], name: 'bam')).to eq({})
    end
  end

  context 'when the path needs to be URL-escaped' do

    let(:url) do
      'foo%5Ebar/_aliases/bar%2Fbam'
    end

    it 'performs the request' do
      expect(client_double.indices.put_alias(index: 'foo^bar', name: 'bar/bam')).to eq({})
    end
  end
end
