#!/usr/bin/env bash

set -euo pipefail

MCP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "${MCP_ROOT}/../.." && pwd)"
LOCKED_ENV_KEYS=""

trim_whitespace() {
  local value="$1"

  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"

  printf '%s' "${value}"
}

load_env_file() {
  local env_file="$1"
  local line
  local key
  local value

  while IFS= read -r line || [[ -n "${line}" ]]; do
    [[ -z "$(trim_whitespace "${line}")" ]] && continue
    [[ "${line}" =~ ^[[:space:]]*# ]] && continue

    if [[ "${line}" == export[[:space:]]* ]]; then
      line="${line#export }"
    fi

    key="$(trim_whitespace "${line%%=*}")"
    value="${line#*=}"

    [[ -n "${key}" ]] || continue

    if locked_env_key "${key}"; then
      continue
    fi

    eval "export ${key}=${value}"
  done < "${env_file}"
}

capture_locked_env_keys() {
  LOCKED_ENV_KEYS="$(env | cut -d= -f1)"
}

locked_env_key() {
  local key="$1"

  printf '%s\n' "${LOCKED_ENV_KEYS}" | grep --fixed-strings --line-regexp --quiet -- "${key}"
}

load_mcp_env() {
  local env_file

  capture_locked_env_keys

  for env_file in "${APP_ROOT}/.env" "${APP_ROOT}/.env.mcp"; do
    if [[ -f "${env_file}" ]]; then
      load_env_file "${env_file}"
    fi
  done
}

mcp_env_hint() {
  printf '%s' "Set it in your shell, ${APP_ROOT}/.env, or ${APP_ROOT}/.env.mcp."
}

require_env() {
  local var_name="$1"
  local message="$2"

  if [[ -z "${!var_name:-}" ]]; then
    printf '%s\n' "${message}" >&2
    exit 1
  fi
}
