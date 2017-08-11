module RepoAudit
  class RepositoryHelper
    class << self
      def find(user:, name:)
        github_client.repository("#{user}/#{name}")
      end

      def list(user:)
        github_client.repositories(user)
      end

      def last_commit(user:, name:)
        github_client.commits("#{user}/#{name}").first
      end

      private

      def github_client
        Octokit::Client.new(access_token: ENV.fetch('GH_TOKEN'))
      end
    end
  end
end
