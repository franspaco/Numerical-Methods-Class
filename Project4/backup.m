function [VO, R] = ortogonaliza(V, eps)
	S = size(V);
	E(:, 1) = V(:, 1);
	R = 2;
	for j = 2:S(2)
		res = 0;
		for k = 1:(j - 1)
			disp(['Calc ' num2str(k) ' -> ' num2str(j)]);
			A(k, j) = dot(V(:,j), E(:,k)) / dot( E(:,k), E(:,k));
			res -= E(:,k) * A(k, j);
		end
		temp = V(:, j) + res
		if all( temp == 0) == 1
			disp(['ES CERO']);
		else
			%E(:,R) = temp;
			R++;
		end
    E(:,R) = temp;
		E
	end
	VO = E;
	R = A;
end
