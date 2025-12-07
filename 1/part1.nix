let
  data = import ./data.nix;
  utils = import ../utils.nix;

  accum = acc : spin :
    let
	  n = utils.nmod ((builtins.elemAt acc 0) + spin) 100;
      occ = builtins.elemAt acc 1;
      nocc = if (n == 0) then occ + 1 else occ;
    in
      builtins.seq n [n nocc]; # force n to be evaluated to avoid stack overflow

  result = builtins.foldl' accum [50 0] data.turns;
in {
  inherit result;
}

