let
  input = builtins.readFile ./input.txt;
  mod = a: b: a - (b * (a / b));
  nmod = a: b:
	let
	  v = mod a b;
	in
	  if (v < 0) then v + b else v;
  

  parseLine = s:
    let
      pair = builtins.split "(R|L)" s;
      dir = builtins.head (builtins.elemAt pair 1);
      v = builtins.fromJSON (builtins.elemAt pair 2);
      mul = if (dir == "R") then 1 else -1;
    in
	  v * mul;

  turns = builtins.map parseLine
	(builtins.filter 
	  (l : l != "" && (!builtins.isList l)) 
	  (builtins.split "\n" input));

  accum = acc : spin :
    let
	  n = nmod ((builtins.elemAt acc 0) + spin) 100;
      occ = builtins.elemAt acc 1;
      nocc = if (n == 0) then occ + 1 else occ;
    in
      builtins.seq n [n nocc]; # force n to be evaluated

  result = builtins.foldl' accum [50 0] turns;
in {
  inherit result;
}

