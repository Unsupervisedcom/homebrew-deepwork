#!/usr/bin/env bash
set -euo pipefail

# Update the Homebrew formula with the latest version from PyPI
# Usage: ./scripts/update-formula.sh [version]
# If no version is provided, fetches the latest from PyPI

FORMULA_PATH="Formula/deepwork.rb"

if [[ -n "${1:-}" ]]; then
    VERSION="$1"
else
    VERSION=$(curl -sL "https://pypi.org/pypi/deepwork/json" | jq -r '.info.version')
fi

echo "Updating formula to version $VERSION"

# Get the tarball URL and SHA256
PYPI_DATA=$(curl -sL "https://pypi.org/pypi/deepwork/${VERSION}/json")
URL=$(echo "$PYPI_DATA" | jq -r '.urls[] | select(.packagetype == "sdist") | .url')
SHA256=$(echo "$PYPI_DATA" | jq -r '.urls[] | select(.packagetype == "sdist") | .digests.sha256')

if [[ -z "$URL" || -z "$SHA256" ]]; then
    echo "Error: Could not fetch tarball info for version $VERSION"
    exit 1
fi

echo "URL: $URL"
echo "SHA256: $SHA256"

# Update the formula
sed -i "s|url \"https://files.pythonhosted.org/packages/[^\"]*\"|url \"$URL\"|" "$FORMULA_PATH"
sed -i "s|sha256 \"[a-f0-9]*\"|sha256 \"$SHA256\"|" "$FORMULA_PATH"

echo "Formula updated successfully"
