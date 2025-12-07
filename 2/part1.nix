let
  inherit (builtins) map filter any foldl' trace genList;
  data = import ./data.nix;
  utils = import ../utils.nix;
  inherit (utils) mod pow sumList range;

  makeConstraint = p:
	let
	  digits = p + 1;
	  upper = (pow 10 digits);
	  lower = (upper / 10);
	  mod = upper + 1;
	in {
	  inherit mod upper lower;
	};

  constraints = genList makeConstraint 5;
  fit = num : constraint :
	let
	  q = num / constraint.mod;
	in
	  (constraint.lower <= q) && (q < constraint.upper) && (num == q * constraint.mod);
  
  invalid = num: any (c: (fit num c)) constraints;

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
