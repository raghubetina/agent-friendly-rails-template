# Run using bin/ci

CI.run do
  step "Setup", "bin/setup --skip-server"

  step "Build assets", "RAILS_ENV=test bin/rails assets:precompile"
  step "Prepare test database", "RAILS_ENV=test bin/rails db:test:prepare"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"
  step "Lint: StandardRB", "bundle exec standardrb"
  step "Lint: Gemfile ordering", "bundle exec rubocop --only Bundler/OrderedGems Gemfile"
  step "Lint: Herb", "bundle exec herb analyze ."
  step "Tests", "bundle exec rspec"

  # Optional: set a green GitHub commit status to unblock PR merge.
  # Requires the `gh` CLI and `gh extension install basecamp/gh-signoff`.
  # if success?
  #   step "Signoff: All systems go. Ready for merge and deploy.", "gh signoff"
  # else
  #   failure "Signoff: CI failed. Do not merge or deploy.", "Fix the issues and try again."
  # end
end
