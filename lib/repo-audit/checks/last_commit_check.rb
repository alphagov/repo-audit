module RepoAudit
  module Checks
    class LastCommitCheck < BaseCheck
      register_check :last_commit

      def run(repo)
        commit = RepositoryHelper.last_commit(user: repo.owner.login, name: repo.name)
        author = commit[:commit][:author]
        result(
          timestamp: author[:date],
          author: {
            name: author[:name],
            email: author[:email]
          }
        )
      end
    end
  end
end
