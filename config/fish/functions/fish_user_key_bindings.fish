function fish_user_key_bindings
    fish_vi_key_bindings

    set --universal fish_cursor_default block
    set --universal fish_cursor_insert line

    bind \cn accept-autosuggestion
    bind --mode insert \cn accept-autosuggestion
end
