
echo "task docker:7 blocked for more than 300 seconds." |systemd-cat -t kernel

echo "Error trying v2 registry: failed to register layer: rename /var/lib/docker/image/test /var/lib/docker/image/ddd: directory not empty.*" |systemd-cat -t docker
