let
  data = import ./data.nix;
  utils = import ../utils.nix;

  accum = { n, occ } : spin :
    let
	  sum = n + spin;
	  q = sum / 100;
	  bump = if (spin > 0) then q else 
		(if (sum > 0) then 0 else
		  (if (n == 0) then -q else 1 - q));

	  occ' = occ + bump;
	  v = sum - q * 100;

	  n' = if (v < 0) then v + 100 else v;
    in
	  builtins.trace (builtins.seq bump (builtins.seq n' { inherit bump spin n'; }))
      builtins.seq n {n = n'; occ = occ';};

  result = builtins.foldl' accum {n = 50; occ =0;} data.turns;
in {
  inherit result;
}

