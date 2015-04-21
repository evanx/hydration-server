

c0count() {
  redis-cli keys "post:*" | wc -l
}

c0print_dict() {
  echo; echo redis-cli keys "post:dict:*"
  redis-cli keys "post:dict:*" | wc -l
  echo; echo redis-cli keys "post:dict:*"
  for key in `redis-cli keys "post:dict:*"`
  do
    echo; echo redis-cli hkeys "$key"
    redis-cli hkeys "$key"
    echo; echo redis-cli hgetall "$key"
    redis-cli hgetall "$key"
  done
}

c0print_seq() {
  echo; echo 'seq'
  for key in `redis-cli keys "post:seq:*"`
  do
    echo; echo redis-cli get "$key"
    redis-cli get "$key"
  done
}

c0print_set() {
  echo; echo 'set'
  for key in `redis-cli keys "post:set:*"`
  do
    echo; echo redis-cli smembers "$key"
    redis-cli smembers "$key"
  done
}

c0print_sorted() {
  for key in `redis-cli keys "post:sorted:*"`
  do
    echo; echo redis-cli zrange "$key" 0 -1
    redis-cli zrange "$key" 0 -1
  done
}

c0print() {
  c0print_dict
  c0print_set
  c0print_seq
  c0print_sorted
}

c0clear() {
  c0count
  for key in `redis-cli keys "post:*"`
  do
    redis-cli del "$key"
  done
  c0count
}

if [ $# -gt 0 ]
then
  command=$1
  shift
  c$#$command $@
else
  c0print
fi
