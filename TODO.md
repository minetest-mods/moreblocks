please don't accept a PR with this file, this is meant to be a checklist of things that i think need to be done before
\[wip] status can be removed

### ag TODO

```
stairsplus/craft_schemas.lua
3:-- TODO: add more of these, e.g. crafting/combining micro/panel/slabs, convert any single node to micro_8, etc.

stairsplus/api/station.lua
13:TODO this isn't actually modular in the right way for adding different kinds of stations
14:TODO e.g. some of this stuff is very particular to the saw itself

stairsplus/API.md
3:TODO: write new API docs
```

### other things

* finish updating documentation, for both users and API
* update translations (i18n, locale)
* unified_inventory / i3 support
* finish testing (and creating) legacy support
* create a way to analyze and reduce node_count
* ? create a way for admins to execute a command to create a config option to register a shaped node?

### future goals

* port other "microblocks" mods to use this framework, e.g. pkarcs and facade
* maybe integration w/ the technic cnc and such
