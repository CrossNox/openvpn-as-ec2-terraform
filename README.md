# OpenVPN terraform
## On AWS EC2 - Using docker

This terraform project allows you to quickly create an OpenVPN Access Server on AWS EC2 using Docker. The structure is such that you can switch to another region easily.

# Using
## Key pairs
You are going to need a key pair created for each region you will use.

## Init terraform
`terraform init`

## `variables.tf`
The AMI ids are updated as of 2021-01-11. Add any other region you might need to the map. To use a different region, just change the `region` var. 

_note_: a `t2.nano` does not have enough RAM to run the docker image. A nice improvement here would be to use a spot instance. 

## Create infrastructure
1. `terraform apply`
2. Review changes
3. Confirm and wait

## Set VPN up
1. `xdg-open https://$(cat ec2_openvpn_ip)`/admin
2. Log in to the admin console
3. Agree to the EULA
4. Set `Configuration -> Network Settings -> Hostname or IP Address`
5. Set `Configuration -> VPN Settings -> Routing` to `Yes, using routing`
6. Go to the user console (`xdg-open https://$(cat ec2_openvpn_ip)`) and download the `ovpn` file from `Yourself (user locked profile)`
7. Depending on your OS, use that file as necessary to connect to the VPN 
8. You can now browse the web and traffic will come from that AWS region.

## Destroy infrastructure
`terraform destroy`

