# GithubApi::V4::Client

A very thin GitHub GraphQL API v4 client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_api-v4-client'
```

## Usage

```rb
client = GithubApi::V4::Client.new("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

client.schema
# {"data"=>
#   {"__schema"=>
#     {"types"=>
#       [{"name"=>"Repository",
#         "kind"=>"OBJECT",
#         "description"=>"A repository contains the content for a project.",
#         "fields"=>
#          [{"name"=>"nameWithOwner"},

client.graphql(query: 'query { repository(owner: "k0kubun", name: "hamlit") { nameWithOwner } }')
# {"data"=>{"repository"=>{"nameWithOwner"=>"k0kubun/hamlit"}}}

client.graphql(query: <<~QUERY, variables: { name: 'hamlit' })
  query Repository($name: String!) {
    repository(owner: "k0kubun", name: $name) {
      nameWithOwner
    }
  }
QUERY
# {"data"=>{"repository"=>{"nameWithOwner"=>"k0kubun/hamlit"}}}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/k0kubun/github_api-v4-client.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
