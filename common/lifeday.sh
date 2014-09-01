lifeday(){   echo $(( ($(date --date="$(date +"%y%m%d")" +%s) - $(date --date="19870618" +%s) )/(60*60*24) )); }
