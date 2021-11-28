### edit prom configmap
```
k edit configmap loki-prometheus-server
```
### add the following alert to alerting_rules.yml
```
    groups:
    - name: example
      rules:
      - alert: ContainerKilled
        expr: time() - container_last_seen > 60
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "Container killed (instance {{ $labels.instance }})"
          description: "A container has disappeared\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
```
### reload
```
curl -XPOST 192.168.166.149:9090/-/reload
```
