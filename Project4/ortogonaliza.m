function [VO, R] = ortogonaliza(V, eps)
	E(:, 1) = V(:, 1);
	R = 2;
	for j = 2:size(V)(2)
		res = 0;
		for k = 1:(R - 1)
			A(k, j) = dot(V(:,j), E(:,k)) / dot( E(:,k), E(:,k));
			res -= E(:,k) * A(k, j);
		end
		temp = V(:, j) + res;
		if all( abs(temp) <= eps) == 0
			E(:,R++) = temp;
		end
	end
	R--;
	VO = E;
end
