require_relative 'spec_helper'

describe RepoAudit::RepositoryHelper do
  let(:github_client) { spy('github_client') }

  before do
    allow(ENV).to receive(:fetch).with('GH_TOKEN').and_return('dummy-token')
    allow(Octokit::Client).to receive(:new).with(access_token: 'dummy-token').and_return(github_client)
  end

  context '.last_commit' do
    let(:commits) { double(Array) }

    it 'fetches the last commit using the Github client' do
      expect(github_client).to receive_message_chain(commits: commits).with('org/repo')
      expect(commits).to receive(:first)

      described_class.last_commit(user: 'org', name: 'repo')
    end
  end

  context '.find' do
    it 'raises an exception when required arguments are not supplied' do
      expect { described_class.find(foo: 'bar') }.to raise_error(ArgumentError)
    end

    it 'retrieves the repository using the Github client' do
      expect(github_client).to receive(:repository).with('user/name')
      described_class.find(user: 'user', name: 'name')
    end
  end

  context '.list' do
    it 'raises an exception when required arguments are not supplied' do
      expect { described_class.list(foo: 'bar') }.to raise_error(ArgumentError)
    end

    it 'retrieves the list of repositories using the Github client' do
      expect(github_client).to receive(:repositories).with('user')
      described_class.list(user: 'user')
    end
  end
end
