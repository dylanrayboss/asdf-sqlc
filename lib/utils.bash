#!/usr/bin/env bash

set -euo pipefail

GO_PACKAGE="github.com/sqlc-dev/sqlc/cmd/sqlc"
GH_REPO="https://github.com/sqlc-dev/sqlc"
TOOL_NAME="sqlc"
TOOL_TEST="sqlc --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" = "version" ]; then
		version="v$version"
	fi

	(
		asdf current golang >/dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "An asdf Go version has already been selected; I'll use that to build $TOOL_NAME."
		else
			echo "No asdf Go version is selected; I'll install the latest version to build $TOOL_NAME."

			# In order to build a Go application from source, we need a Go compiler.
			asdf plugin add golang || true
			asdf install golang latest

			# We can't use `asdf shell` within an `asdf plugin test` environment. For
			# compatibility with both `asdf plugin test` and `asdf install`, we'll
			# configure the Go version with `asdf local`; and to avoid making unwanted
			# modifications to .tool-versions in the pwd, we'll move somewhere else.
			mkdir -p "$install_path"
			cd "$install_path"
			asdf local golang latest
		fi

		# Now we can let the Go toolchain retrieve and install the application as
		# normal, except that we'll dump the binary into the install path instead
		# of $GOPATH/bin.
		export GOBIN="$install_path"
		go install "$GO_PACKAGE"@"$version" || fail "An error occurred while installing $TOOL_NAME $version."

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
