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
    [R, E, M] = sumarMatrices(A, B);
  endswitch
end

function [R, E, M] = sumarMatrices(A, B, N)
  if size(A) ~= size(B)
    E = 1;
    R = 0;
    if N==1
      M = 'Las dimensiones de las matrices impiden su suma.';
    elseif N==2
      M = 'Las dimensiones de las matrices impiden su resta.';
    end
  else
    E = 0;
    M = 0;
    for j = 1:size(A)(1)
      for k = 1:size(A)(2)
        if N==0
          R(j,k) = A(j,k) + B(j,k);
        elseif N==1
          R(j,k) = A(j,k) - B(j,k);
        end
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
    M = 0;
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
