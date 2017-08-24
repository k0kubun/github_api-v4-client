RSpec.describe GithubApi::V4::Client do
  it 'raises error for invalid credentials' do
    expect {
      GithubApi::V4::Client.new('invalid credential').schema
    }.to raise_error(GithubApi::V4::Client::ClientError)
  end
end
