
function o = fraction2bin(n, a)
  o = '';
  res = 0;
  for j = 1:a
    temp = res + 1/(2**j);
    if temp <= n
      o = strcat(o, '1');
      res = temp;
    else
      o = strcat(o, '0');
    end
  end
end
%0000001110111001010
