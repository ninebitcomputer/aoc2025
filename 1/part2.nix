let
  data = import ./data.nix;
  utils = import ../utils.nix;

  accum = { n, occ } : spin :
    let
	  n' = utils.nmod (n + spin) 100;
      occ' = if (n == 0) then occ + 1 else occ;
    in
      builtins.seq n {n = n'; occ = occ';};

  result = builtins.foldl' accum {n = 50; occ =0;} data.turns;
in {
  inherit result;
}

