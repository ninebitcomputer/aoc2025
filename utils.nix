let
  mod = a: b: a - (b * (a / b));
  nmod = a: b:
	let
	  v = mod a b;
	in
	  if (v < 0) then v + b else v;

  split = regex : input : builtins.filter (s : s != "" && !builtins.isList s) (builtins.split regex input);
  flatten = builtins.foldl' (acc : cur : acc ++ cur) [];
in {
  inherit mod nmod split flatten;
}
