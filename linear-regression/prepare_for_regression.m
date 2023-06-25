function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
	[m, n] = size(InitialMatrix);
	FeatureMatrix = zeros(m, n);
	for i = 1 : m
		extra_cols = 0;
		for j = 1 : n
			% If the value is a string we change it according
			% to the specifications. When we get to the furnishing
			% state, we increase extra_cols so that we can
			% make sure the next values we add don't overwrite
			% the others (since for one column we have to add two
			% in the new matrix)
			if ~isnumeric(InitialMatrix{i, j})
				if strcmp(InitialMatrix{i, j}, 'yes')
					FeatureMatrix(i, j + extra_cols) = 1;
				elseif strcmp(InitialMatrix{i, j}, 'no')
					FeatureMatrix(i, j + extra_cols) = 0;   
				elseif strcmp(InitialMatrix{i, j}, 'semi-furnished')
					FeatureMatrix(i, j + extra_cols) = 1; 
					FeatureMatrix(i, j + extra_cols + 1) = 0; 
					extra_cols = extra_cols + 1;
				elseif strcmp(InitialMatrix{i, j}, 'unfurnished')
					FeatureMatrix(i, j + extra_cols) = 0; 
					FeatureMatrix(i, j + extra_cols + 1) = 1;
					extra_cols = extra_cols + 1;
				elseif strcmp(InitialMatrix{i, j}, 'furnished')
					FeatureMatrix(i, j + extra_cols) = 0; 
					FeatureMatrix(i, j + extra_cols + 1) = 0;
					extra_cols = extra_cols + 1;
				end
			% If it is numeric, we copy the value the way it is
			else
				if isnumeric(InitialMatrix{i, j})
					FeatureMatrix(i, j + extra_cols) = InitialMatrix{i, j};   
				end
			end
		end
	end
end
