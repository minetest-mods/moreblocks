#!/usr/bin/env bash

luacheck --config ./invsaw/.luacheckrc -q ./invsaw
luacheck --config ./moreblocks/.luacheckrc -q ./moreblocks
luacheck --config ./stairsplus/.luacheckrc  -q ./stairsplus
luacheck --config ./stairsplus_legacy/.luacheckrc  -q ./stairsplus_legacy

