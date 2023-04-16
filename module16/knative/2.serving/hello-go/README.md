# Go Cloud Events Function

Welcome to your new Go Function! The boilerplate function code can be found in [`handle.go`](handle.go). This Function is meant to respond exclusively to [Cloud Events](https://cloudevents.io/), but you can remove the check for this in the function and it will respond just fine to plain vanilla incoming HTTP requests.

## Development

Develop new features by adding a test to [`handle_test.go`](handle_test.go) for each feature, and confirm it works with `go test`.

Update the running analog of the function using the `func` CLI or client library, and it can be invoked using a manually-created CloudEvent:

```console
curl -v -X POST -d '{"message": "hello"}' \
  -H'Content-type: application/json' \
  -H'Ce-id: 1' \
  -H'Ce-source: cloud-event-example' \
  -H'Ce-subject: Echo content' \
  -H'Ce-type: MyEvent' \
  -H'Ce-specversion: 1.0' \
  http://localhost:8080/
```

For more, see [the complete documentation]('https://github.com/knative/func/tree/main/docs')

