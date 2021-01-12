variable "profile" {
  default = ""
}

variable "region" {
  default = "eu-west-2"
}

variable "key_pair_name" {
  default = ""
}

variable "private_key_location_prefix" {
  default = ""
}

variable "ami_id_amzn_linux_2_hvm" {
  type = map
  default = {
	"eu-west-1":"ami-01720b5f421cf0179",     	# ireland
	"eu-west-2":"ami-0e80a462ede03e653",     	# london
	"eu-west-3":"ami-00798d7180f25aac2",     	# paris
	"eu-central-1":"ami-03c3a7e4263fd998c",  	# frankfurt
	"sa-east-1":"ami-022082b7f1da62478",     	# sao paulo
	"us-east-1":"ami-0be2609ba883822ec",     	# north virginia
        "us-east-2":"ami-0a0ad6b70e61be944",     	# ohio
	"us-west-1":"ami-03130878b60947df3",     	# norhern california
	"us-west-2":"ami-0a36eb8fadc976275",     	# oregon
	"ap-northeast-1": "ami-01748a72bed07727c",	# tokyo
  }
}

variable "instance_type" {
  default = "t2.micro"
}

