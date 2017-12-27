# frozen_string_literal: true

require 'sls_adf/util/token'
require 'sls_adf/util/adapter'

module SlsAdf
  module Util
    COMMON_HEADERS = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }.freeze
  end
end
