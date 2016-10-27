function AK = svdApprox(A,k)

AK = [];
if k < 1
	error('k must be a positive integer!');
	return;
end

[U,S,V] = svd(A);
try
	U  = U(:,1:k); 		% extract only columns 1 to k in U
	S  = S(1:k,1:k); 	% extract a k*k square matrix from S
	V  = V(:,1:k); 		% extract only columns 1 to k in V
	AK = U*S*V';
catch ME
	if strcmp(ME.identifier, 'MATLAB:badsubscript')
		error('k cannot be bigger than the range of A!');
	else
		rethrow(ME);
	end
end
