pkg load signal

% Custom variables
n_images = 30;
n_ref    = 10;
dst = 'csv';
downscale = 3;

images_ans = dir('scan/*.jpg');
images_ref = dir('scan/reference/*.jpg');

n_ref    = length(images_ref)
n_images = length(images_ans)


%filename = 'survey_';
% answers_survey = [filename];
if (rem(n_images,n_ref) > 0)
  error('ERROR');
end

for i=0:n_images/n_ref-1
  answers_survey{i+1,1} = images_ans(n_ref*i+1).name;
  answers_survey{i+1,2} = [];
  for j=0:n_ref-1
    im_name   = images_ans(n_ref*i+j+1).name;
    im_folder = images_ans(n_ref*i+j+1).folder;
    im_num = str2num(im_name(end-7:end-4));
    page = rem(im_num, n_ref);
    if (page == 0)
      page = n_ref;
    end

    ref_name   = images_ref(page).name;
    ref_folder = images_ref(page).folder;
    
    answers_page = analyze_page([im_folder '/' im_name], page, [ref_folder '/' ref_name], downscale);
    
	  answers_survey{i+1,2} = [answers_survey{i+1,2} answers_page];
    
    movefile([im_folder '/' im_name], [im_folder '/done/']);
  end
end

for i=1:n_images/n_ref
  filename = answers_survey{i,1};
  fid = fopen([dst '/' 'output' '.csv'], 'a');
  fprintf(fid, '%s,', filename);
  fclose(fid);
  dlmwrite([dst '/' 'output' '.csv'], answers_survey{i,2}, '-append');
end


