# A Kakoune plugin for seamless `cht.sh` usage.
# See [cht.sh](https://github.com/chubin/cheat.sh)
# Inspired by [this video](https://www.youtube.com/watch?v=hJzqEAf2U4I)

# TODOs
# - [ ] use built-in `terminal` command/s instead of `tmux neww bash -c`
# - [ ] plain chtsh command to support top-level requests like `:help`

define-command chtsh-lang -override -params 1 \
-docstring 'query cht.sh about a language
Special cheat sheets (select w/ query, dependent on language support):
- `hello` describes how you can start with the language
- `:list` shows all topics related to the language
- `:learn` shows a learn-x-in-minutes language cheat sheet perfect for getting started with the language.
- `1line` is a collection of one-liners in this language
- `weirdness` is a collection of examples of weird things in this language
Query options:
- append /1, /2, etc. to the query to get a different answer
- append search options, like /i:
  i   case insensitive search
  b   word boundaries
  r   recursive search' %{
    prompt 'query:' -shell-script-candidates %{
        printf '%s\n' ':list' ':learn' 'hello' '1line' 'weirdness'
    } %{
        nop %sh{
            query=$(echo $kak_text | tr ' ' '+')
# For debugging, enable this and change `nop` to `echo`:
            # printf '%s\n' "curl cht.sh/$1/$query"

            # See the comments in the `chtsh-util` implementaion for alternative
            # lauch strategies...
            tmux neww -n "cht.sh" bash -c "curl https://cht.sh/$1/$query | kak"
        }
    }
}
alias global chl chtsh-lang
complete-command chtsh-lang shell-script-candidates %{
    # https://github.com/chubin/cheat.sh#programming-languages-cheat-sheets
    echo 'arduino assembly awk bash basic bf c chapel clean clojure coffee cpp csharp d dart delphi dylan eiffel elixir elisp elm erlang factor fortran forth fsharp go groovy haskell java js julia kotlin latex lisp lua matlab nim ocaml octave perl perl6 php pike python python3 r racket ruby rust scala scheme solidity swift tcsh tcl objective-c vb vbnet cmake django flask git' | tr ' ' '\n'
}

define-command chtsh-util -override -params 1 \
-docstring 'query cht.sh about a unix utility
Query options:
- append /1, /2, etc. to the query to get a different answer
- append search options, like /i:
  i   case insensitive search
  b   word boundaries
  r   recursive search' %{
    prompt 'query:' %{
        nop %sh{
            query=$(echo $kak_text | tr ' ' '+')
            # For debugging, enable this and change `nop` to `echo`:
            # printf '%s\n' "curl cht.sh/$1/`echo $kak_text | tr ' ' '+'`"

            # Output directly to a terminal:
            # tmux neww -n "cht.sh" bash -c "curl https://cht.sh/$1~$query & while [ : ]; do sleep 1; done"

            # Output to less pager w/ colors:
            # tmux neww -n "cht.sh" bash -c "curl https://cht.sh/$1~$query | less -R"

            # Output to kak, removing ansi color codes:
            # tmux neww -n "cht.sh" bash -c "curl https://cht.sh/$1~$query?T | kak"

            # Output to kak w/ colors via the https://github.com/eraserhd/kak-ansi plugin:
            tmux neww -n "cht.sh" bash -c "curl https://cht.sh/$1~$query | kak"
        }
    }
}
alias global chu chtsh-util
complete-command chtsh-util shell
