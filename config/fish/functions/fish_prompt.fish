function fish_prompt
    set -U __fish_git_prompt_show_informative_status 1

    set -l time (set_color green) [(date +%H:%M:%S)]
    set -l dir (set_color --bold cyan) (prompt_pwd)
    set -l vcs (set_color --bold yellow) (fish_vcs_prompt)
    set -l pointer (set_color normal) '> '

    echo ''
    echo $time $dir $vcs
    echo $pointer
end
