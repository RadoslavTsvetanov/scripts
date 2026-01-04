# Git Aliases
# Add to your .zshrc: [ -f ~/.git_aliases.zsh ] && source ~/.git_aliases.zsh

# Basic commands
alias ga='git add .'
alias gaa='git add --all'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend'

# Push/Pull
alias gp='git push'
alias gpl='git pull'
alias gpo='git push origin'
alias gplo='git pull origin'

# Branches
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'

# Merge/Rebase
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'

# Logs
alias gl='git log --oneline --graph --decorate'
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Diff
alias gd='git diff'
alias gds='git diff --staged'

# Stash
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'

# Reset/Clean
alias gr='git reset'
alias grh='git reset --hard'
alias gclean='git clean -fd'
alias gundo='git reset --soft HEAD~1'

# Other
alias gf='git fetch'
alias gsh='git show'
alias gt='git tag'
