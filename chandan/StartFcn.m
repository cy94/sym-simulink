% This is the StartFcn callback for a Simulink model

% name of the open model
model_name = bdroot();

% get all blocks
blks = find_system(model_name, 'Type', 'Block');

% add listener to each block
disp('Adding callbacks')

for i = 1:length(blks)
	disp(blks{i});
	listener{i} = add_exec_event_listener(blks{i}, 'PostOutputs', @blockCallback);
end

disp('Callbacks added')
