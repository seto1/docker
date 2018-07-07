stty rows 24 cols 80

alias p="cd /var/www/html"

function fish_user_key_bindings
    bind \cr peco_select_history
end
