fid = fopen('input.txt', 'r');
data = fscanf(fid, '%s');

number_of_lines = sqrt(length(data));

trees = [];
for i = 1:number_of_lines
    x = data(i*number_of_lines - number_of_lines + 1:i*number_of_lines);
    cells = [];
   for j = 1:length(x)
    cells = [cells, str2num(x(j)) ];
  end
  trees = [trees;cells];
end

visible = zeros([number_of_lines,number_of_lines]);


function v =  view_from_left(trees,visible,number_of_lines)
  for i = 1:number_of_lines
    visible(i,1) = 1;
    max = trees(i,1);
  for j = 2:number_of_lines
      if trees(i,j) > max
        visible(i,j) = 1;
        max = trees(i,j);
      endif
  end
end
  v = visible;
  endfunction

function s = score_to_right(trees,number_of_lines)
  s = zeros([number_of_lines,number_of_lines]);
  for i = 2:(number_of_lines -1)
  for j = 2:(number_of_lines -1)
    view = j + 1;
    score = 0;
    while view <= number_of_lines
      score += 1;
      if trees(i,view) >= trees(i,j)
        break;
      endif
      view += 1;
  endwhile
  s(i,j) = score;
endfor
endfor
endfunction

function s = four_hadamard_product(a,b,c,d,number_of_lines)
  s = zeros([number_of_lines,number_of_lines]);
  for i = 1:number_of_lines
  for j = 1:number_of_lines
      s(i,j) = a(i,j)*b(i,j)*c(i,j)*d(i,j);
  endfor
endfor
endfunction


visible = view_from_left(trees,visible,number_of_lines);
s1 = score_to_right(trees,number_of_lines);
trees = rot90(trees);

visible = rot90(visible);

visible = view_from_left(trees,visible,number_of_lines);
s2 = rot90(score_to_right(trees,number_of_lines),3);

trees = rot90(trees);

visible = rot90(visible);

visible = view_from_left(trees,visible,number_of_lines);
s3 = rot90(score_to_right(trees,number_of_lines),2);


trees = rot90(trees);

visible = rot90(visible);

visible = view_from_left(trees,visible,number_of_lines);
s4 = rot90(score_to_right(trees,number_of_lines));

trees = rot90(trees);

visible = rot90(visible);


sum(visible(:))



scores  = max(four_hadamard_product(s1,s2,s3,s4,number_of_lines)(:))
