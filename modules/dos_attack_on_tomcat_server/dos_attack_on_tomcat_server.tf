resource "shoreline_notebook" "dos_attack_on_tomcat_server" {
  name       = "dos_attack_on_tomcat_server"
  data       = file("${path.module}/data/dos_attack_on_tomcat_server.json")
  depends_on = [shoreline_action.invoke_block_ip]
}

resource "shoreline_file" "block_ip" {
  name             = "block_ip"
  input_file       = "${path.module}/data/block_ip.sh"
  md5              = filemd5("${path.module}/data/block_ip.sh")
  description      = "Identify the source of the DoS attack and block the IP address or range."
  destination_path = "/agent/scripts/block_ip.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_block_ip" {
  name        = "invoke_block_ip"
  description = "Identify the source of the DoS attack and block the IP address or range."
  command     = "`chmod +x /agent/scripts/block_ip.sh && /agent/scripts/block_ip.sh`"
  params      = ["BLOCK_DURATION_SECONDS","IP_ADDRESS"]
  file_deps   = ["block_ip"]
  enabled     = true
  depends_on  = [shoreline_file.block_ip]
}

