% Francisco Huelsz
% A01019512

% ************************** Funcion principal *********************************
function [x, E, indx] = noLineal(x0, eps, maxit, method)
  if method == 0
    [x, E, indx] = NR(x0, eps, maxit);
  elseif method == 1
    [x, E, indx] = secant(x0, eps, maxit);
  elseif method == 2
    [x, E, indx] = bisect2(x0, eps, maxit);
  end
end

% ************************** Metodo de Newton **********************************
function [x, E, indx] = NR(X0, eps, maxit)
  E = 1;
  x = 'El metodo no converge con la entrada dada';
  indx = maxit;
  %X n menos 1
  Xn(1) = X0;
  for j = 2:maxit
    %El indice empieza un número arriba porque los arreglos
    %  en octave empiezan en 1 en lugar de 0
    Xn(j) = Xn(j-1) - f( Xn(j-1) )/df( Xn(j-1) );
    %if(abs(Xn - Xnm1) < eps)
    if( abs( Xn(j) - Xn(j-1) ) < eps )
      x = Xn(j);
      indx = j-1;
      E = 0;
      break;
    end
  end
end

% *************************** Metodo de secante ********************************
function [x, E, indx] = secant(Xn, eps, maxit)
  E = 1;
  x = 'El metodo no converge con la entrada dada';
  indx = maxit;
  for j = 3:maxit
    %El indice empieza un número arriba porque los arreglos
    %  en octave empiezan en 1 en lugar de 0
    Xn(j) = Xn(j-1) - ( f( Xn(j-1) ) * ( Xn(j-1) - Xn(j-2) ) )/( f( Xn(j-1) ) - f( Xn(j-2) ) );
    if( abs( Xn(j) - Xn(j-1) ) < eps )
      x = Xn(j);
      indx = j-1;
      E = 0;
      indx = j-1;
      break;
    end
  end
end

% ************************* Metodo de biseccion ********************************
function [x, E, indx] = bisect2(Xn, eps, maxit)
  [x, itOut] = bisect(maxit, eps, Xn(1), Xn(2));
  E = 0;
  indx = maxit - itOut;
end

function [x, itOut] = bisect(it, eps, lo, hi)
  loIsPos = f(lo) > 0;
  mid = (lo + hi) / 2;
  x = mid;
  if (it <= 0) || (abs(mid - hi) < eps)
    x = mid;
    itOut = it;
    return;
  else
    if f(mid) > 0
      run = loIsPos;
    else
      run = not(loIsPos);
    end

    if run
      [x, itOut] = bisect(--it, eps, mid, hi);
    else
      [x, itOut] = bisect(--it, eps, lo, mid);
    end
  end
end
