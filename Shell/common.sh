STATISTICS() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e  "\e[1;31m FAILURE \e[0m"
    exit;
  fi
}
PRINT() {
   echo -e "\e[33m$1\e[0m"
}
