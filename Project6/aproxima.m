function [A, E] = aproxima(X, Y, N, O, P)
  E = 0;
  %Configuraci´on gráfica
  clf;
  hold on;
  xlabel('x', 'fontsize', 18);
  ylabel('y', 'fontsize', 18);
  set(gca, 'linewidth', 4, 'fontsize', 18);

  %Selección de método
  if O == 0
    if size(X)(2) > N
      A  = interpola(X, Y, N, P);
    else
      A = 'NaN';
      E = 1;
    end
  elseif O == 1
    A = minimos(X, Y, N, P);
  end

  %Graficar puntos de datos
  plot(X(1,:), Y(1,:), '+k', 'markersize', 10, 'linewidth', 2);

  %Graficar línea
  x0 = (min(X(1,:))-2):0.05:(max(X(1,:))+2);
  y0 = A(1)(1);
  for j = 1:N
    y0 += A(j+1)(1)*(x0.^j);
  end
  plot(x0, y0, 'r', 'linewidth', 2);

  %Graficar puntos predictivos
  Yo = ones(1,size(P)(2))*A(1)(1);
  for j = 1:N
    Yo(1,:) += A(j+1)(1)*(P(1,:).^j);
  end
  plot(P(1,:), Yo(1,:), 'xb', 'markersize', 10, 'linewidth', 2);

  hold off;
end

function A = interpola(X, Y, N, P)
  title(['Interpolación de grado ' num2str(N) ' con ' num2str(N+1) ' puntos.'], 'fontsize', 18);
  if N > 1
    bottom = 1;
    while X(1,bottom + 1) < mean(P(1,:))
      bottom++;
    end
    disp(['Bottom: ' num2str(bottom)]);
    top = bottom;
    s = 0;
    while ( top - bottom ) < (N-2)
      if mod(s,2) == 0
        if top < size(X)(2)-1
          top++;
        else
          top = size(X)(2)-1;
        end
      else
        if bottom > 2
          bottom--;
        else
          bottom = 2;
        end
      end
      s++;
    end
    Xo = [X(1,1) X(1,bottom:top) X(1,size(X)(2))];
    Yo = [Y(1,1) Y(1,bottom:top) Y(1,size(Y)(2))]';
  else
    Xo = [X(1,1) X(1,size(X)(2))];
    Yo = [Y(1,1) Y(1,size(Y)(2))]';
  end

  for k = 1:size(Xo)(2)
    B(k,1) = 1 ;
    for l = 1:N
      B(k,l+1) = Xo(k)**l;
    end
  end

  A = inv(B)*Yo;

end

function A = minimos(X, Y, N, P)
  title(['Minimos cuadrados con regresion de grado ' num2str(N)], 'fontsize', 18);
  for j = 1:size(X)(2)
    B(j,1) = 1 ;
    for k = 1:N
      B(j,k+1) = X(j)**k;
    end
  end
  A = inv(B'*B)*(B'*Y');
end
