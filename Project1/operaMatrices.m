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
    % Las dimensiones de las matrices no son iguales, por lo que no se
    % pueden sumar o restar.
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
      % Por cada fila de A
      for k = 1:size(A)(2)
        % Por cada columna de A

        % Sumar el elemento en (j,k) en a con el elemento en la
        % misma posición en B
        R(j,k) = A(j,k) + (D*B(j,k));
      end
    end
  end
end

function [R, E, M] = multiplicarMatrices(A, B, N)
  if size(A)(2) ~= size(B)(1)
    % La cantidad de columnas en A no es igual a la cantidad de filas de B,
    % por lo que no pueden multiplicarse.
    M = 'Las dimensiones de las matrices impiden su multiplicacion.';
    E = 1;
    R = 0;
  else
    E = 0;
    M = 'No hay error.';
    for j=1:size(A)(1)
      % Por cada fila de A
      for k=1:size(B)(2)
        % Por cada columna de B

        % Inicializar a 0
        R(j,k) = 0;

        for l=1:size(B)(1)
          % Por cada fila de B

          % Sumar el producto de A(j,l) y B(l,k)
          R(j,k) += A(j,l)*B(l,k);
        end
      end
    end
  end
end

function [R, E, M] = analizarMatrices(A)
  for j = 1:size(A)(1)
    % Por cada fila de A
    R(j,1) = 0;
    R(j,2) = 0;
    columns = size(A)(2);
    for k = 1:columns
      % Por cada columna en A

      % Sumar el valor de cada columna en la fila
      R(j,1) += A(j,k);
    end
    % Dividir entre el número de columnas para sacar promedio
    R(j,1) = R(j,1)/columns;

    for k = 1:columns
      % Por cada columna en A

      % Sumar el cuadrado de la diferencia del promedio de la
      % fila y el elemento de cada columna
      R(j,2) += (A(j,k)-R(j,1))**2;
    end

    % Dividir entre (numero de columnas - 1)
    R(j,2) = R(j,2)/(columns-1);

    %Sacar raiz cuadrada de la varianza
    R(j,2) = sqrt(R(j,2));
  end
  E = 0;
  M = 'No hay error.';
end

function [R, E, M] = maxMinMatrices(A)
  for j = 1:size(A)(2)
    % Para cada columna en A

    % Iniciar máximo y  minimo al primer valor
    max = A(1,j);
    min = max;

    for k = 1:size(A)(1)
      % Para cada fila en A
      if A(k,j) > max
        % Si el elemento es mayor al máximo anterior es el nuevo máximo
        max = A(k,j);
      end
      if A(k,j) < min
        % Si el elemento es menor al mínimo anterior es el nuevo mínimo
        min = A(k,j);
      end
    end
    R(1,j) = max;
    R(2,j) = min;
    E = 0;
    M = 'No hay error.';
  end
end
