function A = aproxima(X, Y, N, O, P)
  clf;
  hold on;
  xlabel('x', 'fontsize', 18);
  ylabel('y', 'fontsize', 18);
  set(gca, 'linewidth', 4, 'fontsize', 18);


  if O == 0
    %A = interpola();
  elseif O ==1
    A = minimos(X, Y, N, P);
  end
  plot(X(1,:), Y(1,:), '+k', 'markersize', 10, 'linewidth', 2);
  hold off;
end

function A = interpola(X, Y, N, P)

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
  x0 = (min(X(1,:))-2):0.05:(max(X(1,:))+2);
  y0 = A(1)(1);
  for j = 1:N
    y0 += A(j+1)(1)*(x0.^j);
  end
  plot(x0, y0, 'r', 'linewidth', 2);
  Yo = ones(1,size(P)(2))*A(1)(1);
  for j = 1:N
    Yo(1,:) += A(j+1)(1)*(P(1,:).^j);
  end
  plot(P(1,:), Yo(1,:), 'xb', 'markersize', 10, 'linewidth', 2);

end
