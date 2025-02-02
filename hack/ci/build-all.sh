#!/usr/bin/env bash
# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# simple CI script to verify kind's own sources
# TODO(bentheelder): rename / refactor. consider building kindnetd

set -o errexit -o nounset -o pipefail

# cd to the repo root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${REPO_ROOT}"

# build and test kind
hack/release/build/cross.sh
hack/go_container.sh go test -v ./...

# build and test kindnetd
cd "${REPO_ROOT}/images/kindnetd"
"${REPO_ROOT}/hack/go_container.sh" go build -v -o /out/kindnetd ./cmd/kindnetd
"${REPO_ROOT}/hack/go_container.sh" go test -v ./...
