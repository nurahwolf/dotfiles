if command -q nvim
	set -gx EDITOR nvim
else if command -q vim
	set -gx EDITOR vim
end
