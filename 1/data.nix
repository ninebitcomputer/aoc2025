let
  input = builtins.readFile ./input.txt;
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
in {
  inherit turns;
}
