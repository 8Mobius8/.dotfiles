#!/usr/bin/env bash

function __prompt() {
    readonly RESET='\[\[\033[0m\]'
    readonly COLOR_DIM='\[\[\033[2m\]'
    readonly COLOR_GIT='\[\[\033[1m\]'
    readonly COLOR_GIT_CLEAN='\[\[\033[92m\]'
    readonly COLOR_WARN='\[\[\033[93m\]'
    readonly SYMBOL_GIT_BRANCH=''
    readonly SYMBOL_GIT_COMMIT='•'
    readonly SYMBOL_GIT_PUSH='+'
    readonly SYMBOL_GIT_PULL='-'
    readonly SYMBOL_GIT_MODIFIED='Δ'

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
        local countModified=0
  
        while IFS= read -r line; do
          if [[ $line =~ ahead\ ([0-9]+) ]]; then
            marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
          elif [[ $line =~ behind\ ([0-9]+) ]]; then
            marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
          elif [[ $line =~ ^\ M ]]; then
            (( countModified++ ))
          fi
        done < <(git status --porcelain 2>/dev/null)
        
        if [[ countModified -gt 0 ]]; then
          marks=" $SYMBOL_GIT_MODIFIED$countModified $marks"
        fi

        if [[ -n "$marks" ]]; then
          # print the git branch segment without a trailing newline
          printf "$COLOR_WARN$ref$marks$RESET"
        else
          # print the ref as clean
          printf "$COLOR_GIT_CLEAN$ref$RESET"
        fi  
    }

    __mobius_ps1() {
      local jobs="$COLOR_DIM[$RESET\j$COLOR_DIM]$RESET "
      local host="\u$COLOR_DIM@\h$RESET "
      local path="\w "
      local cmdBegin="$COLOR_DIM\n\$$RESET "

      if shopt -q promptvars; then
         __mobius_line_git_info="$(__git_info)"
         local git="$COLOR_GIT${__mobius_line_git_info}$RESET "
      else
	  # promptvars is disabled. Avoid creating unnecessary env var.
	 local git="$COLOR_GIT$(__git_info)$RESET "
      fi

      PS1="$jobs$host$path$git$cmdBegin"
    }

    PROMPT_COMMAND=__mobius_ps1
}

__prompt
unset __prompt
