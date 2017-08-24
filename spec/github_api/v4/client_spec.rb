require "spec_helper"

RSpec.describe GithubApi::V4::Client do
  it "has a version number" do
    expect(GithubApi::V4::Client::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
