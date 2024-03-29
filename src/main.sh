
git_ahead_list() {
  local branch
  local current_branch
  local ahead_rev_list
  local behind_rev_list

  git fetch --all --quiet

  current_branch=$(git rev-parse --abbrev-ref HEAD)

  git for-each-ref --format='%(refname:short)' refs/heads | while read -r branch; do
    if [ "${branch}" != "${current_branch}" ]; then
      ahead_rev_list=$(git rev-list --count "${current_branch}".."${branch}")
      if [ "${ahead_rev_list}" -gt "0" ]; then
        behind_rev_list=$(git rev-list --count "${branch}".."${current_branch}")

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

main() {
  local list
  local width

  list="$(git_ahead_list)"
  width=$(echo "${list}" | wc -L)

  echo "${list}" | git_ahead_sort | git_ahead_format "${width}"
}
