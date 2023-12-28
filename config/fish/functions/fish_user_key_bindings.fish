function fish_user_key_bindings
    fish_vi_key_bindings
    set -U fish_cursor_insert line
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion
end
