if status is-interactive
    # Commands to run in interactive sessions can go here
end

function git_url_convert
    set -l url $argv[1]
    set -l username (string replace -r 'https://github.com/([^/]+)/.*' '$1' $url)
    set -l reponame (string replace -r 'https://github.com/[^/]+/(.*)' '$1' $url)
    echo "git@github.com:$username/$reponame.git"
end

function connect_phone
    adb forward tcp:2222 tcp:2222
    ssh root@localhost -p 2222
end

set -U fish_greeting

alias ls 'exa'
alias cat 'bat'
alias neovide 'neovide --fork'
alias btop 'btop --utf-force'
alias fix_git_url 'git config set remote.origin.url (git_url_convert (git config --get remote.origin.url))'

fish_add_path -g ~/bin
