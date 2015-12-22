function date = UTC_to_IST(x)

date = datestr((x+19800)/86400 + datenum(1970,1,1));