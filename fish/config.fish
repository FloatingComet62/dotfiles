if status is-interactive
    # Commands to run in interactive sessions can go here
end

function git_url_convert
    set -l url $argv[1]
    set -l username (string replace -r 'https://github.com/([^/]+)/.*' '$1' $url)
    set -l reponame (string replace -r 'https://github.com/[^/]+/(.*)' '$1' $url)
    echo "git@github.com:$username/$reponame.git"
end

set -U fish_greeting

alias ls 'ls --color=auto'
alias neovide 'neovide --fork'
alias btop 'btop --utf-force'
alias fix_git_url 'git config set remote.origin.url (git_url_convert (git config --get remote.origin.url))'

fish_add_path -g ~/bin
