# OpenVPN terraform
## On AWS EC2 - Using docker

This terraform project allows you to quickly create an OpenVPN Access Server on AWS EC2 using Docker. The structure is such that you can switch to another region easily.

# Setting everything up - How to use
This assumes you have the AWS CLI and terraform installed. If not, refer to the appropriate documentation for your OS.

## Key pairs
You are going to need a key pair created for each region you will use.

## Init terraform
`terraform init`

## `variables.tf`

### `profile`
This is the AWS CLI profile to use. If the location you use is not the default, change it on `provider.tf`.

### Key pairs location
Key pairs locations are interpolated like `<private_key_location_prefix>/<region>/<key_pair_name>`. So, note that to switch regions quickly, all key pairs should be named the same and be located under the same folder and inside of a folder named like the region they belong to.

For instance, this would be an appropriate layout:

```text
.
└── project_name/
    ├── us-west-1/
    │   └── key_pair.pem
    ├── us-west-2/
    │   └── key_pair.pem
    ├── us-east-1/
    │   └── key_pair.pem
    └── us-east-2/
        └── key_pair.pem
```

And you would set `private_key_location_prefix` to `something/project_name`, and `key_pair_name` to `key_pair.pem`.

So, leave `key_pair_name` and `private_key_location_prefix` as constants. `region` should be changed as needed.

### `ami_id_amzn_linux_2_hvm`
The AMI ids are updated as of 2021-01-11. Add any other region you might need to the map. To use a different region, just change the `region` var. 

### `instance_type`
The instance type to use. These should be x86 machines, or if using ARM, update the AMI ids mapping.

_note_: a `t2.nano` does not have enough RAM to run the docker image. A nice improvement here would be to use a spot instance to reduce costs. 

## Create infrastructure
1. `terraform apply`
2. Review changes
3. Confirm and wait

## Set VPN up
1. `xdg-open https://$(cat ec2_openvpn_ip)/admin`
2. Log in to the admin console
3. Agree to the EULA
4. Set `Configuration -> Network Settings -> Hostname or IP Address` to the IP from `ec2_openvpn_ip`
5. Set `Configuration -> VPN Settings -> Routing` to `Yes, using routing`
6. Go to the user console (`xdg-open https://$(cat ec2_openvpn_ip)`) and download the `ovpn` file from `Yourself (user locked profile)`
7. Depending on your OS, use that file as necessary to connect to the VPN
8. You can now browse the web and traffic will come from that AWS region.

## Destroy infrastructure
`terraform destroy`

