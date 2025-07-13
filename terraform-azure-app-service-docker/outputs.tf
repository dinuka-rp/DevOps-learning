output "linux_web_app_name" {
  value = azurerm_linux_web_app.gpt_app.name
}

output "app_url" {
  value = "https://${azurerm_linux_web_app.gpt_app.default_hostname}"
}