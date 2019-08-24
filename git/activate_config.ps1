"[include]`n`tpath = $("${PSScriptRoot}\gitconfig".replace('\','/'))`n" | out-file "${home}\.gitconfig" -Encoding "utf8" -NoNewline
#"[core]`n`teditor = '$((Get-Command vim).path.replace('\','/'))'`n" | out-file "${home}\.gitconfig" -Encoding "utf8" -NoNewline -Append
