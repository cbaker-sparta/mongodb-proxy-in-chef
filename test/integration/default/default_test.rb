# InSpec test for recipe correct_mongodb::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
# This is an example test, replace it with your own test.

describe upgrade 'mongodb-org' do
  it { should be_installed }
  its( 'version' ) { should match /3\./ }
end

describe port(27017) do
  it { should be_listening }
end

describe service "mongodb-org" do
  it { should be_running }
  it { should be_enabled }
end
