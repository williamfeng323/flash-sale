#!/bin/bash
source ./profiles/credentials.bashrc
node ./node_modules/.bin/_mocha -r ./node_modules/ts-node/register -t 30000000 $(find test -name '*.test.ts')
