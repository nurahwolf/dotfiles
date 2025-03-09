# if 1password is installed, set `SSH_AUTH_SOCK` to it.

if type -q 1password
	set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
end
