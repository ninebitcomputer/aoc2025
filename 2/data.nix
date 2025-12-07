let
  inherit (builtins) head tail fromJSON;
  utils = import ../utils.nix;
  input = builtins.readFile ./input.txt;
  parse = s:
	  let
		r = utils.split "-" s;
	  in  {
		beg = fromJSON (head r);
		end = fromJSON (head (tail r));
		
	  };

  parsed = builtins.map parse (utils.split "," input);
  sorted = builtins.sort (e1 : e2 : e1.beg < e2.beg) parsed;
in {
  inherit sorted;
}
