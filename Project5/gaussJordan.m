function [x, Ainv, d, S] = gaussJordan(A, B, op)
  S = op;
  if size(A)(1) ~= size(A)(2)
    %return;
  end

  len = size(A)(1);

  if op == 1
    %Solucion
    Ainv = 0;
    [x, S, d] = eliminar(A,B, op);
  elseif op == 2
    %Determinante e inversa
    x = 0;
    [Ainv, S, d] = eliminar(A, eye(size(A)(1)), op);
  elseif op == 3
    x = pivoteo(A);
    Ainv = 0;
    d = 0;
    S = 0;
  end
end;


function [z, S, d] = eliminar(x, y, S)
  len = size(x)(1);
  z = [x y];

  z = pivoteo(z); %pivotear

  for j = 1:(len-1) %columnas
    for k = (j+1):len   %renglones
      z(k,:) = z(k,:) - z(k,j)/z(j,j)*z(j,:);
    end
  end
  %z
  for j = len:-1:2 %columnas
    for k = (j-1):-1:1   %renglones
      z(k,:) = z(k,:) - z(k,j)/z(j,j)*z(j,:);
    end
  end

  d = diagonal(z);

  for j = 1:len
    z(j,:) = z(j,:)/z(j,j);
  end

  z(:,1:len) = [];

end;


function A = pivoteo (A)
  len = size(A)(1);

  for j = 1:(len-1) %columnas
    [x, ix] = max(abs(A(j:len,j)));
    ix += j-1;
    if ix ~= j
      temp = A(j,:);
      A(j,:) = A(ix,:);
      A(ix,:) = temp;
    end
  end
end

function y = diagonal (A)
  len = size(A)(1);
  y = 1;
  for j = 1:len %columnas
    y *= A(j,j);
  end
end
