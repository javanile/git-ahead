
usage() {
  echo "Git-Ahead is a tool that identifies branches with commits ahead of the current branch" >&2
  echo "" >&2
  echo "Usage: git ahead [OPTIONS]" >&2
  echo "" >&2
  echo "Available options" >&2
  echo "  --held       Display this help message" >&2
}

main() {
  local list
  local width
  local has_remote
  local current_branch

  if [ "$1" = "--help" ]; then
    usage
    exit 0
  fi

  current_branch=$(git rev-parse --abbrev-ref HEAD)
  has_remote=$(git ls-remote --heads origin | grep "${current_branch}$" || true)

  if [ -z "${has_remote}" ]; then
    echo "error: The current branch '${current_branch}' has no upstream branch." >&2
    echo "To push the current branch and set the remote as upstream, use" >&2
    echo "" >&2
    echo "    git push --set-upstream origin ${current_branch}" >&2
    echo "" >&2
    echo "To have this happen automatically for branches without a tracking" >&2
    echo "upstream, see 'push.autoSetupRemote' in 'git help config'." >&2
    exit 1
  fi

  list="$(git_ahead_list "${current_branch}")"

  if ! echo "$list" | grep -q '[^[:space:]]'; then
    echo "info: The current branch '${current_branch}' is up to date with no missing updates." >&2
    exit 1
  fi

  width=$(echo "${list}" | wc -L)

  echo "${list}" | git_ahead_sort | git_ahead_format "${width}"
}

git_ahead_list() {
  local branch
  local current_branch
  local ahead_rev_list
  local behind_rev_list
  local branch_list

  git fetch --all --quiet

  current_branch="$1"

  # Retrieve the list of local branches
  # branch_list=$(git for-each-ref --format='%(refname:short)' refs/heads)

  # Retrieve the list of remote branches
  branch_list=$(git ls-remote --heads origin | awk '{sub("refs/heads/", "", $2); print $2}')

  echo "${branch_list}" | while read -r branch; do
    if [ "${branch}" != "${current_branch}" ]; then
      ahead_rev_list=$(git rev-list --count "${current_branch}".."origin/${branch}")
      if [ "${ahead_rev_list}" -gt "0" ]; then
        behind_rev_list=$(git rev-list --count "origin/${branch}".."${current_branch}")

        echo "${branch} ${behind_rev_list} ${ahead_rev_list}"
      fi
    fi
  done
}

git_ahead_sort() {
  sort -k3rn,3 -k2n,2
}

git_ahead_format() {
  local branch
  local ahead_rev_list
  local behind_rev_list
  local formatted_branch
  local formatted_behind_rev_list
  local width

  width=${1:-30}

  while read -r branch behind_rev_list ahead_rev_list; do
    formatted_branch=$(printf "%-${width}s" "$branch")
    formatted_behind_rev_list=$(printf "%3s" "$behind_rev_list")

    echo "${formatted_branch} ${formatted_behind_rev_list} | ${ahead_rev_list}"
  done
}
