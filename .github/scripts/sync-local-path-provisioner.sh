#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/rancher/local-path-provisioner.git"
chart_dir="charts/local-path-provisioner"
chart_yaml="${chart_dir}/Chart.yaml"

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

echo "Updated local-path-provisioner chart to ${latest_tag}"
