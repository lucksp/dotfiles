# profile color change based on branch status
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  c_reset='\[\e[0m\]'
  c_user='\[\e[1;34m\]' # light blue
  c_path='\[\e[1;32m\]' # light green
  c_git_clean='\[\e[0;37m\]' # light gray
  c_git_staged='\[\e[0;32m\]' # green
  c_git_untracked='\[\e[0;31m\]' # red
  c_git_unknown='\[\e[0;33m\]' # brown
else
  c_reset=
  c_user=
  c_path=
  c_git_clean=
  c_git_staged=
  c_git_untracked=
  c_git_unknown=
fi

git_branch_for_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  if ! git_status=$(git status --porcelain 2>&1); then
        git_color="$c_git_unknown"
  elif [ -z "$git_status" ]; then
    git_color="$c_git_clean"
  elif echo "$git_status" | egrep "^(.[^ ])" > /dev/null 2>&1; then
    git_color="$c_git_untracked"
  else
    git_color="$c_git_staged"
  fi

  branch=$(git rev-parse --abbrev-ref HEAD)

  if [ "$branch" == "develop" ]; then
        git_color=`echo $git_color | sed 's/0;/1;/'`
  fi

  echo "[$git_color$branch${c_reset}] "

  unset git_status git_color branch

  return 0
}

export_git_branch ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    export GIT_BRANCH=NOT_CURRENTLY_INSIDE_GIT_REPO
  else
    export GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  fi

}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

PROMPT_COMMAND='PS1="\!:${c_path}\w${c_reset} $(git_branch_for_prompt)\$ "; history -a; export_git_branch'
