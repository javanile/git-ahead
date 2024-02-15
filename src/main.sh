
main() {
  local branch
  local current_branch
  local ahead_rev_list
  local behind_rev_list
  local formatted_branch
  local formatted_behind_rev_list

  git fetch --all --quiet

  current_branch=$(git rev-parse --abbrev-ref HEAD)

  git for-each-ref --format='%(refname:short)' refs/heads | while read -r branch; do
    if [ "${branch}" != "${current_branch}" ]; then
      ahead_rev_list=$(git rev-list --count "${current_branch}".."${branch}")
      if [ "${ahead_rev_list}" -gt "0" ]; then
        behind_rev_list=$(git rev-list --count "${branch}".."${current_branch}")
        formatted_branch=$(printf "%-30s" "${branch}")
        formatted_behind_rev_list=$(printf "%3s" "${ahead_rev_list}")

        echo "${formatted_branch} ${formatted_behind_rev_list} | ${ahead_rev_list}"
      fi
    fi
  done
}
