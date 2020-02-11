if status --is-interactive
  set -g fish_user_abbreviations

  abbr d docker
  abbr dc docker-compose
  abbr dcdv 'docker-compose down -v'
  abbr dsp 'docker system prune -a'

  abbr g git
  abbr gc 'git checkout'
  abbr gc- 'git checkout -'
  abbr gcb 'git checkout -b'
  abbr gcm 'git checkout master'
  abbr gm 'git merge'
  abbr gpl 'git pull'
  abbr gpu 'git push'
  abbr gs 'git stash'
  abbr gsp 'git stash pop'
  abbr gaa 'git add -A'
  abbr gcomm 'git commit -m'

  abbr y yarn
end