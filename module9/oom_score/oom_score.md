### Create a burstable pod and a guaranteed pod

### Check the `oom_score` and `oom_score_adj`

```sh
crictl ps|grep nginx
crictl inspect b2e7a8e64253d|grep pid
cat /proc/296290/oom_score
cat /proc/296290/oom_score_adj
```

### Find all processes which oom scores are not 0

```sh
#!/bin/bash
printf 'PID\tOOM Score\tOOM Adj\tCommand\n'
while read -r pid comm; do [ -f /proc/$pid/oom_score ] && [ $(cat /proc/$pid/oom_score) != 0 ] && printf '%d\t%d\t\t%d\t%s\n' "$pid" "$(cat /proc/$pid/oom_score)" "$(cat /proc/$pid/oom_score_adj)" "$comm"; done < <(ps -e -o pid= -o comm=) | sort -k 2nr
```
