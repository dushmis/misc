#!/bin/bash

set -e

for_a_while=60; #wait for 60 seconds
this_file=${1:-/dev/null}; #file to monitor
toemail=${2:-test@me.com}; #send email to
mdir="$HOME/.moni"; #token file location

#create if directory does not exist
if [[ ! -d "$mdir" ]]; then
  mkdir "$mdir";
fi

#token file 
token_file="$mdir/$(basename "$this_file")_token";

#check if file exists
if [[ ! -e "$this_file" ]]; then
  echo "$this_file: No such file or directory";
  exit 1;
fi

#check if we have read permission
if [[ ! -r "$this_file" ]]; then
  echo "$this_file: We do not have read rermission";
  exit 1;
fi

#check if token file already exists..
if [[ ! -e "$token_file" ]]; then
  touch "$token_file";
fi



while :;
do
  if [[ "$this_file" -nt "$token_file" ]]; then #file changed
    dt="$(date +"%c")";
    dt="${dt// /_}";
    mail -s "$this_file changed - $dt" "$toemail" <<< "$(tail -20 "$this_file")";
    #change timestamp
    cat > "$token_file" /dev/null;
    echo "file changed...";
  fi
  sleep $for_a_while;
done

