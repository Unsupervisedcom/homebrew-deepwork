#!/usr/bin/env bash
set -euo pipefail

# Test the Homebrew formula using the official homebrew/brew Docker image
# Usage: ./scripts/test-formula.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "Testing deepwork formula..."

docker run --rm -v "$REPO_DIR:/tap" homebrew/brew:latest bash -c '
set -euo pipefail

# Add the local tap
brew tap-new --no-git local/deepwork
cp /tap/Formula/deepwork.rb "$(brew --repository)/Library/Taps/local/homebrew-deepwork/Formula/"

# Audit the formula
echo "==> Auditing formula..."
brew audit --strict local/deepwork/deepwork || true

# Install the formula
echo "==> Installing formula..."
brew install --verbose local/deepwork/deepwork

# Test the formula
echo "==> Testing formula..."
brew test local/deepwork/deepwork

# Verify the binary works
echo "==> Verifying binary..."
deepwork --help

echo "==> All tests passed!"
'
