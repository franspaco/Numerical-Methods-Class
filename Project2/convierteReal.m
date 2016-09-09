
function [R, E] = convierteReal(n, m, e, b)
  if b == 0
    [R, E] = toBin(n, m, e);
  elseif b == 1
    [R, E] = toDec(n, m, e);
  end
end

%******************************* DEC to BIN ************************************
function [R, E] = toBin(n, m, e)
  % Regresa el string binario normalizado equivalente a un decimal
  E = 0;
  sb = '0';
  eb = '0';
  exp = '0';
  mantissa = '';
  or = n;
  if n < 0
    sb = '1';
    n = abs(n);
  end

  a = dec2bin(floor(n));
  b = floating2bin(n, 2*m);
  mantissa = strcat(a,b);

  if a == '0'
    eb = '1';
    temp = index(b, '1');
    exp = temp - 1;

    if exp == 0
      eb = '0';
    end

    exp = dec2bin(exp, e);
    exp = substr(exp, -e);

    mantissa = substr(mantissa, temp + 1);

  else
    exp = dec2bin(length(a), e);
    exp = substr(exp, -e);
    mantissa =  substr(mantissa, 1, m);
  end
  R = strcat(sb, '-', eb, '-', exp, '-', mantissa);
  R = strcat(sb, eb, exp, mantissa)

  %disp('ToDec');
  %toDec(R, m, e);
  E = toDec(R, m, e) - or;

end

%******************************** BIN to DEC ***********************************
function [R, E] = toDec(n, m, e)
  % Regresa el equivalente decimal de un string binario normalizado
  E = '';
  sb  = n(1);
  eb  = n(2);
  n
  exp = substr(n, 3, e)
  mantissa = substr(n, 3+e, m);
  exp = bin2dec(exp)
  R = floatingToDec(mantissa);

  if eb == '0'
    R = R * (2**exp);
  elseif eb == '1'
    R = R / (2**exp);
  end

  if sb == '1'
    R = -R;
  end

end

% ****************************** DEC Floating to BIN ***************************
function o = floating2bin(n, a)
  %Recibe decimales después del punto y convierte a binario
  o = '';
  if a < 1
    o = '';
    return;
  end

  n = getFloatingPoint(n);

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
  er = res - n;
end

%****************************** BIN Floating to DEC ****************************
function a = floatingToDec(s)
  %Recibe binario después del punto y convierte a decimal
  a = 0;
  for j = 1:length(s)
    if s(j) == '1'
      a += 1/(2**j);
    end
  end
end

%******************************* Get floating point ****************************
function a = getFloatingPoint(x)
  %Regresa la parte no entera de un número
  a = x - floor(x);
end
