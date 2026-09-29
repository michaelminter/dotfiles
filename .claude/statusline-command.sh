#!/bin/bash
# Claude Code status line: model name + context usage progress bar

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // .rate_limits.seven_day.resets_at // empty')

RESET=$'\033[0m'
CYAN=$'\033[36m'
GRAY=$'\033[90m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'

bar_width=10

model_label="$model"
if [ -n "$effort" ]; then
  model_label="${model} ${GRAY}(${effort})${RESET}${CYAN}"
fi

reset_str=""
if [ -n "$resets_at" ]; then
  now_epoch=$(date +%s)
  diff=$(( resets_at - now_epoch ))
  if [ "$diff" -gt 0 ]; then
    days=$(( diff / 86400 ))
    hours=$(( (diff % 86400) / 3600 ))
    mins=$(( (diff % 3600) / 60 ))
    if [ "$days" -gt 0 ]; then
      reset_str="resets in ${days}d ${hours}h"
    elif [ "$hours" -gt 0 ]; then
      reset_str="resets in ${hours}h ${mins}m"
    else
      reset_str="resets in ${mins}m"
    fi
  fi
fi

if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  filled=$(( used_int * bar_width / 100 ))
  [ "$filled" -gt "$bar_width" ] && filled=$bar_width
  [ "$filled" -lt 0 ] && filled=0
  empty=$(( bar_width - filled ))

  if [ "$used_int" -ge 80 ]; then
    color="$RED"
  elif [ "$used_int" -ge 50 ]; then
    color="$YELLOW"
  else
    color="$GREEN"
  fi

  bar=""
  for ((i = 0; i < filled; i++)); do bar="${bar}█"; done
  for ((i = 0; i < empty; i++)); do bar="${bar}░"; done

  if [ -n "$reset_str" ]; then
    printf "${CYAN}%s${RESET}  ${GRAY}[${color}%s${GRAY}]${RESET} ${color}%s%%${RESET}  ${GRAY}%s${RESET}\n" "$model_label" "$bar" "$used_int" "$reset_str"
  else
    printf "${CYAN}%s${RESET}  ${GRAY}[${color}%s${GRAY}]${RESET} ${color}%s%%${RESET}\n" "$model_label" "$bar" "$used_int"
  fi
else
  if [ -n "$reset_str" ]; then
    printf "${CYAN}%s${RESET}  ${GRAY}%s${RESET}\n" "$model_label" "$reset_str"
  else
    printf "${CYAN}%s${RESET}\n" "$model_label"
  fi
fi
