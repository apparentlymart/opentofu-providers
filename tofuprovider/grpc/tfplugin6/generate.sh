#!/bin/bash

# We do not run protoc under go:generate because we want to ensure that all
# dependencies of go:generate are "go get"-able for general dev environment
# usability.
#
# To adopt a new minor version of plugin protocol 6:
# - copy the new tfplugin6.proto from the commit associated with latest tagged
#   release of OpenTofu over the top of this directory's tfplugin6.proto.
# - Run this generate.sh script to in turn run protoc to regenerate
#   tfplugin6.pb.go.
#
# Terraform's protocol versioning conventions call for all new minor releases
# of protocol 6 to be supersets of all earlier versions. This procedure is not
# appropriate for a hypothetical future major version, which should instead
# have its own package alongside this one to allow the SDK to implement both
# versions at once for a while before removing protocol 6.

set -eu

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

cd "$DIR"

protoc -I ./ tfplugin6.proto --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative
