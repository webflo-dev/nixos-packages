{ lib, newScope, callPackage, ... }:

lib.makeScope newScope (self: with self;
let
  apple = callPackage ./apple { };
in
{
  sf-pro = apple.sf-pro;
  sf-mono = apple.sf-mono;
  new-york = apple.new-york;
  luciole = callPackage ./luciole { };
})
