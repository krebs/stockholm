{ kartei, stockholm, ... }:
{
  imports = [ kartei.outPath ];
  # kartei was split out of stockholm; its entries still rely on stockholm's
  # pure lib (e.g. slib.krebs.genipv6). Provide it here instead of letting
  # kartei reach back into stockholm's tree via a relative path.
  _module.args.slib = stockholm.lib;
}
