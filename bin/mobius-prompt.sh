#!/usr/bin/env bash

function __prompt() {
  readonly RESET='\[\[\033[0m\]'
  readonly COLOR_DIM='\[\[\033[2m\]'
  readonly COLOR_GIT='\[\[\033[1m\]'
  readonly COLOR_GIT_CLEAN='\[\[\033[92m\]'
  readonly COLOR_GIT_WARN='\[\[\033[93m\]'
  readonly COLOR_GIT_ERROR='\[\[\033[91m\]'
  readonly SYMBOL_GIT_BRANCH=''
  readonly SYMBOL_GIT_COMMIT='•'
  readonly SYMBOL_GIT_PUSH='+'
  readonly SYMBOL_GIT_PULL='-'
  readonly SYMBOL_GIT_MODIFIED='Δ'
  readonly SYMBOL_GIT_STAGED='S'

  __git_info() { 
    hash git 2>/dev/null || return # git not found
    local git_eng="env LANG=C git" # force git output in English to make our work easier

    local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)
    local refSymbol
    if [[ -n "$ref" ]]; then
      refSymbol=$SYMBOL_GIT_BRANCH
    else
      refSymbol=$SYMBOL_GIT_COMMIT
      ref="$($git_eng describe --tags --always 2>/dev/null)"
    fi

    [[ -n "$ref" ]] || return  # not a git repo
    ref="$refSymbol $ref"

    local marks
    local modified=0
    local staged=0
    # Read git porclean output line by line.
    while IFS= read -r line; do
      # Read 
      if [[ $line =~ ^\#\ branch\.ab\ \+([0-9]+)\ \-([0-9]+) ]]; then
        [[ "${BASH_REMATCH[1]}" -ne 0 ]] && marks+="$COLOR_GIT_CLEAN$SYMBOL_GIT_PUSH${BASH_REMATCH[1]}$RESET"
        [[ "${BASH_REMATCH[2]}" -ne 0 ]] && marks+="$COLOR_GIT_WARN$SYMBOL_GIT_PULL${BASH_REMATCH[2]}$RESET"
      elif [[ $line =~ \.M ]]; then
        (( modified++ ))
      elif [[ $line =~ M\. ]]; then
        (( staged++ ))
      elif [[ $line =~ MM ]]; then
        (( staged++ ))
        (( modified++ ))
      fi
    done < <(git status --porcelain=v2 --branch 2>/dev/null)
    
    if [[ $modified -gt 0 ]]; then
      marks="$COLOR_GIT_ERROR$SYMBOL_GIT_MODIFIED$modified$RESET $marks"
    fi
    if [[ $staged -gt 0 ]]; then
      marks="$COLOR_GIT_WARN$SYMBOL_GIT_STAGED$staged$RESET $marks"
    fi

    # Show red if just git shows only modified changes, yellow if
    # have staged changes, and green if git is clean (excludes untracked changes).
    if [[ "$modified" -ne "0" ]]; then
      printf "$COLOR_GIT_ERROR$ref$RESET $marks"
    elif [[ "$modified" -ne "0" ]] || [[ "$staged" -ne "0" ]]; then
      printf "$COLOR_GIT_WARN$ref$RESET $marks"
    else
      printf "$COLOR_GIT_CLEAN$ref$RESET $marks"
    fi  
  }

  __mobius_ps1() {
    local jobs="$COLOR_DIM[$RESET\j$COLOR_DIM]$RESET "
    local host="\u$COLOR_DIM@\h$RESET "
    local path="\w "
    local cmdBegin="$COLOR_DIM\n\$$RESET "

    if shopt -q promptvars; then
      __mobius_line_git_info="$(__git_info)"
      local git="${__mobius_line_git_info} "
    else
      # promptvars is disabled. Avoid creating unnecessary env var.
      local git="$(__git_info)"
    fi

    PS1="$jobs$host$path$git$cmdBegin"
  }

  PROMPT_COMMAND=__mobius_ps1
}

__prompt
unset __prompt
