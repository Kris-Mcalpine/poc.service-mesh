# Linkerd

## Applying to services

Linkerd uses the annotation `linkerd.io/inject: enabled` on the namespace to determine if it should inject the linkerd proxy.

##  Gotchas

Note the operational concerns around MutualTLS around expiring trust anchors and rotating them:
 <https://linkerd.io/2.12/features/automatic-mtls/#operational-concerns>
