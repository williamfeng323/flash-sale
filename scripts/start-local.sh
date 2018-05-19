#!/bin/bash
tcpproxy --proxyPort 5859 --serviceHost 127.0.0.1 --servicePort 5858 &
./node_modules/.bin/ts-node --inspect-brk=5858 src/server.ts
