this_instance   = search("aws_opsworks_instance", "self:true").first
Chef::Log.error(this_instance)
Chef::Log.error(this_instance["layer_ids"])
Chef::Log.error(search("aws_opsworks_instance", "layer_id:#{this_instance["layer_ids"][0]}"))
