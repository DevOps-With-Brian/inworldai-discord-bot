# Define a variable so we can pass in our token
variable "doppler_token" {
  type = string
  description = "A token to authenticate with Doppler"
}

variable "tags" {
    description = "Tags to apply to domain"
    type = list(string)
    default = ["prod"]
}