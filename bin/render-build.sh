#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install gems
bundle install

# Precompile assets for production
bundle exec rails assets:precompile

# Clean up old assets (optional, but safe to keep)
bundle exec rails assets:clean

# Run database migrations
bundle exec rails db:migrate