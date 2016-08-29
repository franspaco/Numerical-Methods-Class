%
%  Francisco Huelsz
%  A01019512
%

function [R, E, M] = operaMatrices(A, B, N)
  switch(N)
  case {0, 1}
    [R, E, M] = sumarMatrices(A, B, N);
  case 2
    [R, E, M] = multiplicarMatrices(A, B, N);
  case 3
    [R, E, M] = analizarMatrices(A, B);
  case 4
    [R, E, M] = maxMinMatrices(A, B);
  otherwise
    R = 0;
    E = 1;
    M = 'Opcion NO existe!';
  endswitch
end

function [R, E, M] = sumarMatrices(A, B, N)
  if (size(A)(1) ~= size(B)(1)) || (size(A)(2) ~= size(B)(2))
    E = 1;
    R = 0;
    if N==0
      M = 'Las dimensiones de las matrices impiden su suma.';
    elseif N==1
      M = 'Las dimensiones de las matrices impiden su resta.';
    end
  else
    E = 0;
    M = 'No hay error.';
    D = 0
    if N==0
      D = 1;
    elseif N==1
      D = -1;
    end
    for j = 1:size(A)(1)
      for k = 1:size(A)(2)
        R(j,k) = A(j,k) + (D*B(j,k));
      end
    end
  end
end

function [R, E, M] = multiplicarMatrices(A, B, N)
  if size(A)(2) ~= size(B)(1)
    M = 'Las dimensiones de las matrices impiden su multiplicacion.';
    E = 1;
    R = 0;
  else
    E = 0;
    M = 'No hay error.';
    for j=1:size(A)(1)
      for k=1:size(B)(2)
        R(j,k) = 0;
        for l=1:size(B)(1)
          R(j,k) += A(j,l)*B(l,k);
        end
      end
    end
  end
end

function [R, E, M] = analizarMatrices(A)
  for j = 1:size(A)(1)
    R(j,1) = 0;
    R(j,2) = 0;
    columns = size(A)(2);
    for k = 1:columns
      R(j,1) += A(j,k);
    end
    R(j,1) = R(j,1)/columns;

    for k = 1:columns
      R(j,2) += (A(j,k)-R(j,1))**2;
    end
    R(j,2) = R(j,2)/(columns-1);
    R(j,2) = sqrt(R(j,2));
  end
  E = 0;
  M = 'No hay error.';
end

function [R, E, M] = maxMinMatrices(A)
  for j = 1:size(A)(2)
    max = A(1,j);
    min = max;
    for k = 1:size(A)(1)
      if A(k,j) > max
        max = A(k,j);
      end
      if A(k,j) < min
        min = A(k,j);
      end
    end
    R(1,j) = max;
    R(2,j) = min;
    E = 0;
    M = 'No hay error.';
  end
end
