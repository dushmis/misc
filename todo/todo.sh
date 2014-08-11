todo ()
{
  type="text/html";
  subject="TODO - $(date_)";
  to=<email>;
  file=$(cat - );
  file="<head><style>*{font-family:verdana;font-size:12px}</style></head><body><pre>$file</pre>";
  mail -s "$(echo -e "$subject\nContent-Type: $type")" $to <<< $file
}

