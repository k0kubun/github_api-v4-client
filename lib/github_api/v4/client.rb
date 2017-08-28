# frozen_string_literal: true
require 'json'
require 'net/http'
require 'uri'
require 'github_api/v4/client/version'

class GithubApi::V4::Client
  ENDPOINT = URI.parse('https://api.github.com')
  ClientError = Class.new(StandardError)
  ServerError = Class.new(StandardError)

  # @param [String] access_token
  def initialize(access_token)
    @access_token = access_token
  end

  # @param [String] query
  # @param [Hash] variables
  # @return [Hash]
  def graphql(query:, variables: {})
    resp = post('/graphql', query: query, variables: variables)
    handle_errors(resp)
    JSON.parse(resp.body)
  end

  # @return [Hash]
  def schema
    graphql(query: <<~GRAPHQL)
      query {
        __schema {
          types {
            kind
            name
            description
            fields(includeDeprecated: true) {
              name
              description
              args {
                name
                description
                type {
                  name
                }
                defaultValue
              }
              type {
                name
                description
              }
              isDeprecated
              deprecationReason
            }
            inputFields {
              name
              description
              type {
                name
              }
              defaultValue
            }
          }
        }
      }
    GRAPHQL
  end

  # @return [Hash]
  def query_schema
    type('Query')
  end

  # @param [String] name
  # @return [Hash]
  def type(name)
    graphql(query: <<~GRAPHQL)
      query {
        __type(name: #{name.dump}) {
          kind
          name
          description
          fields(includeDeprecated: true) {
            name
            description
            args {
              name
              description
              type {
                name
              }
              defaultValue
            }
            type {
              name
              description
              fields(includeDeprecated: true) {
                name
                description
                args {
                  name
                  description
                  type {
                    name
                  }
                  defaultValue
                }
                type {
                  name
                  description
                }
                isDeprecated
                deprecationReason
              }
            }
            isDeprecated
            deprecationReason
          }
          inputFields {
            name
            description
            type {
              name
            }
            defaultValue
          }
        }
      }
    GRAPHQL
  end

  def rate_limit
    graphql(query: <<~GRAPHQL).dig('data', 'rateLimit')
      query {
        rateLimit {
          remaining
          limit
        }
      }
    GRAPHQL
  end

  private

  def handle_errors(resp)
    case resp
    when Net::HTTPClientError
      raise ClientError.new("#{resp.code}: #{resp.body}")
    when Net::HTTPServerError
      raise ServerError.new("#{resp.code}: #{resp.body}")
    end
  end

  def post(path, params = {})
    Net::HTTP.start(ENDPOINT.host, ENDPOINT.port, use_ssl: ENDPOINT.scheme == 'https') do |http|
      headers = {
        'Authorization': "bearer #{@access_token}",
        'Content-Type':  'application/json',
      }
      http.post(path, params.to_json, headers)
    end
  end
end
