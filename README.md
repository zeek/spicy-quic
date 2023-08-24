# Spicy analyzer for the QUIC protocol

A QUIC protocol analyzer for Zeek, based on Spicy. This analyzer tries to be
compatible with [QUIC IETF version 1](https://datatracker.ietf.org/doc/html/rfc9000)
Current focus is on extraction of ClientHello and ServerHello messages from
INITIAL packets.

Updates via Zeek slack and/or https://github.com/zeek/zeek/issues/2326. Feel free to
contribute via issues/PR's. This code is merely a starting point for future improvements.

> **Note**
>
> This analyzer is not yet considered production ready. Due to the prevalence of
> QUIC traffic in networks these days, deploying this package may significantly
> increase resource usage of individual Zeek workers.
>
> That said, we welcome any feedback and experience.

## Installation

This analyzer can be installed via zkg:
```bash
zkg install https://github.com/zeek/spicy-quic
```

When working with the official [zeek/zeek](https://hub.docker.com/r/zeek/zeek)
container images, install the following dependencies beforehand:
```bash
apt-get update && apt-get install -y --no-install-recommends cmake libpcap-dev build-essential libssl-dev
zkg install https://github.com/zeek/spicy-quic
```


Without `zkg`, build as follows:
```bash
mkdir -p build && cd build && cmake .. && cmake --build .
zeek -Cr ../testing/Traces/quic_win11_firefox_google.pcap spicy-modules/quic.hlto
```

## quic.log

This package produces a new log named ``quic.log`` for INITIAL packets. The
format and structure is a very early draft and may change significantly in
the future.
```json
{
  "ts": 1692782078.971564,
  "uid": "CNahHe3njNtuarYWhg",
  "id.orig_h": "172.17.0.2",
  "id.orig_p": 34347,
  "id.resp_h": "64.233.166.94",
  "id.resp_p": 443,
  "version": "1",
  "client_initial_dcid": "815d62c70884f4b51e8ccadd5beed372",
  "server_scid": "c15d62c70884f4b5",
  "server_name": "www.google.de",
  "client_protocol": "h3"
}
```

## Credits

This repo is a continuation of Fox-IT's initial implementation at [fox-ds/spicy-quic](https://github.com/fox-ds/spicy-quic).
