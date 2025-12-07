let
  inherit (builtins) map filter any foldl' seq genList;
  data = import ./data.nix;
  utils = import ../utils.nix;
  inherit (utils) mod flatten;

  mods = [11 1010 100100 10001000 1000010000 ];
  invalid = num: any (m: (mod num m) == 0) mods;
  sum = a : b : a + b;

  g = r :
	foldl'
	  sum
	  0
	  (filter 
		invalid
		(genList (x : r.beg + x) (r.end - r.beg + 1))
	  );

  solution = foldl' sum 0 (map g data.sorted);

in {
  inherit solution;
}
