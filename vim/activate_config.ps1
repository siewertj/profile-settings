"source $("${PSScriptRoot}\vimrc".replace('\','/'))" | out-file "${home}\.vimrc" -Encoding "utf8"
