{ lib, newScope, ... }:

lib.makeScope newScope (self: with self;{
  fonts = callPackage ./fonts { };
})
