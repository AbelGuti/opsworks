this_instance   = search("aws_opsworks_instance", "self:true").first
Chef::Log.error(search("aws_opsworks_layer", "layer_ids:#{this_instance["layer_ids"][0]}"))
