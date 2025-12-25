#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/rancher/local-path-provisioner.git"
chart_dir="charts/local-path-provisioner"
chart_yaml="${chart_dir}/Chart.yaml"

if ! command -v yq >/dev/null 2>&1; then
  echo "yq is required on PATH" >&2
  exit 1
fi

if [[ ! -f "${chart_yaml}" ]]; then
  echo "Missing ${chart_yaml}" >&2
  exit 1
fi

current_tag="$(
  awk -F': ' '/^appVersion:/ {print $2}' "${chart_yaml}" | tr -d '"'
)"

if [[ -z "${current_tag}" ]]; then
  echo "Unable to determine current appVersion in ${chart_yaml}" >&2
  exit 1
fi

latest_tag="$(
  git ls-remote --tags --refs "${repo_url}" "v*" \
    | awk -F/ '{print $3}' \
    | sort -V \
    | tail -n 1
)"

if [[ -z "${latest_tag}" ]]; then
  echo "Unable to determine latest tag from ${repo_url}" >&2
  exit 1
fi

if [[ "${current_tag}" == "${latest_tag}" ]]; then
  echo "local-path-provisioner is already up to date at ${current_tag}"
  exit 0
fi

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

git clone --depth 1 --branch "${latest_tag}" "${repo_url}" "${tmp_dir}"

src_chart="${tmp_dir}/deploy/chart/local-path-provisioner"
if [[ ! -d "${src_chart}" ]]; then
  echo "Missing chart directory ${src_chart} in ${repo_url}@${latest_tag}" >&2
  exit 1
fi

rm -rf "${chart_dir}"
mkdir -p "$(dirname "${chart_dir}")"
cp -a "${src_chart}" "${chart_dir}"

app_version="$(yq '.appVersion' "${chart_yaml}" | tr -d '"' | sed 's/^v//')"
if [[ -z "${app_version}" ]]; then
  echo "Missing appVersion in ${chart_yaml}" >&2
  exit 1
fi

IFS='.' read -r major minor patch <<<"${app_version}"
if [[ -z "${major}" || -z "${minor}" || -z "${patch}" ]]; then
  echo "Unexpected appVersion format: ${app_version}" >&2
  exit 1
fi
next_chart_version="${major}.${minor}.$((patch + 1))"
yq -i ".version = \"${next_chart_version}\"" "${chart_yaml}"

echo "Updated local-path-provisioner chart to ${latest_tag} with chart version bump"
