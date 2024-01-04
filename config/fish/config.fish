fish_config theme choose "Just a Touch"

set -U fish_prompt_pwd_dir_length 0
set -U VIRTUAL_ENV_DISABLE_PROMPT 1

if status is-interactive
    # Commands to run in interactive sessions can go here
end

thefuck --alias | source
