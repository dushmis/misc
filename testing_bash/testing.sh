must() {
  if ! "$@"; then
    echo "$@" failed >&2
    exit 2 #must
  fi
}
 
not() {
  if "$@"; then
    false
  else
    true
  fi
}

be(){
 echo >/dev/null "";	
}


must not grep "xx" <<< "yyy" 
must grep -o "yy" <<< "yyyzz"


