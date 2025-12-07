let
  inherit (builtins) map filter any foldl' trace genList;
  data = import ./data.nix;
  utils = import ../utils.nix;
  inherit (utils) mod pow sumList range;

  mods = [11 1010 100100 10001000 1000010000 ];

  makeConstraint = p:
	let
	  upper = (pow 10 p);
	  mod = (pow 10 (2 * p + 1));
	in 3;

  constraints = genList makeConstraint 5;
  
  #invalid = num: any (c: (num < c.upper) && (mod num c.mod) == 0) constraints;
  #invalid = num: any (c: false) constraints;
  invalid = num: false;

  g = r :
	let
	  filtered =
		(filter 
		  invalid
		  (range r.beg (r.end + 1))
		);
	in
		(sumList filtered);

  #solution = sumList (map g data.sorted);
  solution = data.sorted;
in {
  inherit solution;
}
