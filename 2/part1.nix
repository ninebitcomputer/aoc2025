let
  inherit (builtins) map filter any foldl' trace genList;
  data = import ./data.nix;
  utils = import ../utils.nix;
  inherit (utils) mod pow sumList range;

  mods = [11 1010 100100 10001000 1000010000 ];

  makeConstraint = p:
	let
	  upper = (pow 10 p);
	  mod = (pow 10 (2 * p + 1)) + upper;
	in {
	  inherit mod upper;
	};

  constraints = genList makeConstraint 5;
  fit = num : constraint :
	let
	  q = num / constraint.mod;
	in
	  (q < constraint.upper) && (num == q * constraint.mod);
  
  #invalid = num: any (c: trace c ((num < c.upper) && (mod num c.mod) == 0)) constraints;
  invalid = num: any (c: (fit num c)) constraints;
  #invalid = num: any (c: false) constraints;
  #invalid = num: false;

  g = r :
	let
	  filtered =
		(filter 
		  invalid
		  (range r.beg (r.end + 1))
		);
	in
	  trace filtered
		(sumList filtered);

  solution = sumList (map g data.sorted);
in {
  inherit solution;
}
