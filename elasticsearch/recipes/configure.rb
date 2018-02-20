this_instance   = search("aws_opsworks_instance", "self:true").first
search("aws_opsworks_instance", "layer_ids:#{this_instance["layer_ids"][0]}").each do |instance|
  Chef::Log.error(instance)
end
