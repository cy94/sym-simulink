% callback function - this should be in the same directory 
% as the Simulink model OR on the MATLAB path

function blockCallback( block, event )
	blk_handle = block.BlockHandle;
	% get the block object
	this_blk = get(blk_handle);

	fprintf('Block: %s\n\n', this_blk.Name);

	ports = get_param(blk_handle,'PortConnectivity');

	for i = 1 : length(ports)
		% index of the input/output port
		port_index = str2num(ports(i).Type);

		if ~isempty(ports(i).SrcBlock)
			% incoming port
			handle = ports(i).SrcBlock;
			value = block.InputPort(port_index).Data;

			fprintf('Source: ')
		else
			% outgoing port
			handle = ports(i).DstBlock;
			value = block.OutputPort(port_index).Data;

			fprintf('Destination(s): ')
		end
		
		% loop through multiple destinations 
		for j = 1 : numel(handle)
			blk = get(handle(j));
			fprintf('%s\n', blk.Name);
		end

		fprintf('Value: %f\n', value);
		fprintf('\n');
	end

	disp('------------------')
	
end

