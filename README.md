# Trivy PoC on missing CVE on old alpine

Not sure if this is a bug, just made a repo so easy to showcase what I think is a bug:

* Alpine 3.20 w/ `icu-libs` @ `74.2-r1` -> Trivy says OK
* Alpine 3.23 w/ `icu-libs` @ `74.2-r1` (force installed) -> Trivy reports CVE

Shouldn't the CVE be reported even in Alpine 3.20?
