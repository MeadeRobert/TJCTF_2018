def brainfuckize(nb):
    if nb in [-2, -1, 0, 1]:
        return ["~({}<[])", "~([]<[])",
                 "([]<[])",  "({}<[])"][nb+2]

    if nb % 2:
        return "~%s" % brainfuckize(~nb)
    else:
        return "(%s<<({}<[]))" % brainfuckize(nb/2)

def to_char(val):
	return "`'%\\xcb'`[{}<[]::~(~({}<[])<<({}<[]))]%(" + val + ")"
		
secret = 'this_is_the_super_secret_string'

print '+ '.join([to_char(brainfuckize(ord(i))) for i in secret])

