function [x, Ainv, d, S] = gaussJordan(A, B, op)
  S = op;
  if size(A)(1) ~= size(A)(2)
    return;
  end

  len = size(A)(1);
  d = determinante(A);

  if op == 1
    %Solucion

    Ainv = 0;
    if d == 0
      S = 0;
      x = 0;
    else
      x = eliminar(A,B);
      x(:,1:len) = [];
    end
  elseif op == 2
    %Determinante e inversa
    x = 0;
    if d == 0
      Ainv = 0;
      S = 0;
    else
      Ainv = eliminar(A, eye(size(A)(1)));
      Ainv(:,1:len) = [];
    end
  end
end;


function z = eliminar(x, y)
  len = size(x)(1);
  z = [x y];

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

  for j = 1:len
    z(j,:) = z(j,:)/z(j,j);
  end
end;


function d = determinante(A)
  %disp(['NOW: -----------------------------']);
  %A
  d = 0;
  if size(A)(1) == 2 && size(A)(2) == 2
    d = (A(1,1)*A(2,2)) - (A(1,2)*A(2,1));
  else
    for j = 1:size(A)(2)

      value = A(1,j);
      prev = j-1;
      next = j+1;
      siz = size(A)(1);
      min = 2;
      max = size(A)(1) - 1;

      if j == 1
        B = A(min:siz, min:siz);
      elseif j == siz
        B = A(min:siz, 1:max);
      else
        B = [A(min:siz, 1:prev) A(min:siz, next:siz)];
      end

      if mod(j,2) == 1
        d += value*determinante(B);
      else
        d -= value*determinante(B);
      end
    end
  end
end
