let
  mod = a: b: a - (b * (a / b));
  nmod = a: b:
	let
	  v = mod a b;
	in
	  if (v < 0) then v + b else v;

  split = regex : input : builtins.filter (s : s != "" && !builtins.isList s) (builtins.split regex input);

  flatten = builtins.foldl' (acc : cur : acc ++ cur) [];
  sumList = builtins.foldl' (a : b : a + b) 0;
  range = a : b : builtins.genList (x: a + x) (b - a);

  _pow = base: p: acc:
	if p == 0 then
	  acc
	else if (builtins.bitAnd p 1) == 1 then
	  _pow base (p - 1) (acc * base)
	else
	  _pow (base * base) (p / 2) acc;
  pow = base : p : _pow base p 1;

in {
  inherit mod nmod split flatten pow sumList range;
}
