function error = relError(A, AK);

f = @(M) sqrt(sum(sum(M.*M))); % this computes |M| for a matrix M
error = f(A-AK) / f(A);
