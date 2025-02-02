if command -q nvim
	set -gx EDITOR nvim
else if command -q vim
	set -gx EDITOR vim

else if command -q vi
	set -gx EDITOR vi
end
