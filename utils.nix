let
  mod = a: b: a - (b * (a / b));
  nmod = a: b:
	let
	  v = mod a b;
	in
	  if (v < 0) then v + b else v;
in {
  inherit mod nmod;
}
