source ~/.bash_powerline.sh

#############################################
# Bash ls colors
#############################################
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

#############################################
# Bash completion
#############################################
if [ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
  source /opt/homebrew/etc/profile.d/bash_completion.sh
fi

#############################################
# alias
#############################################
alias ll='ls -l'
alias la='ls -la'
alias ls='ls -G'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --colour=auto'
alias ghusage="gh api \"/users/\$(gh api user --jq .login)/settings/billing/usage/summary?product=actions\" | jq '
  def clean_number: if . == floor then floor else . end;
  [.usageItems[] | select(.unitType == \"minutes\")] as \$runners |
  (\$runners[] | {
    runner: .sku,
    used: (.grossQuantity | clean_number),
    discounted: (.discountQuantity | clean_number),
    billed: (.netQuantity | clean_number)
  }),
  {
    total_used: (\$runners | map(.grossQuantity) | add // 0),
    free_remaining: ([2000 - (\$runners | map(.discountQuantity) | add // 0), 0]| max)
  }
'"
